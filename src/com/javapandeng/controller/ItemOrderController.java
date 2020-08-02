package com.javapandeng.controller;

import com.alibaba.fastjson.JSONObject;
import com.javapandeng.base.BaseController;
import com.javapandeng.po.*;
import com.javapandeng.service.*;
import com.javapandeng.utils.Consts;
import com.javapandeng.utils.Pager;
import com.mysql.cj.util.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.json.JsonObject;
import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 订单管理
 *
 * @author 尚郑
 */
@Controller
@RequestMapping("/itemOrder")
public class ItemOrderController extends BaseController {

    @Autowired
    private ItemOrderService itemOrderService;

    @Autowired
    private UserService userService;

    @Autowired
    private CarService carService;

    @Autowired
    private OrderDetailService orderDetailService;

    @Autowired
    private ItemService itemService;

    /**
     * 订单管理列表
     *
     * @return
     */
    @RequestMapping("/findBySql")
    public String findBySql(ItemOrder itemOrder, Model model) {
        //分页查询
        String sql = "select * from item_order where 1=1 ";
        if (!isEmpty(itemOrder.getCode())) {
            sql += " and code like '%" + itemOrder.getCode() + "%' ";
        }
        sql += " order by id desc";
        Pager<ItemOrder> pagers = itemOrderService.findBySqlRerturnEntity(sql);
        model.addAttribute("pagers", pagers);
        //存储查询条件、
        model.addAttribute("obj", itemOrder);
        return "itemOrder/itemOrder";
    }


    /**
     * 我的订单
     *
     * @param model
     * @param request
     * @return
     */
    @RequestMapping("/my")
    public String my(Model model, HttpServletRequest request) {
        //获取登录用户Id
        Object attribute = request.getSession().getAttribute(Consts.USERID);
        //如果没有登录转发到登录页面
        if (attribute == null) {
            return "redirect:/login/uLogin";
        }
        Integer userId = Integer.valueOf(attribute.toString());
        //登录用户的全部订单
        String sql1 = "select * from item_order where user_id=" + userId + " order by id desc";
        List<ItemOrder> all = itemOrderService.listBySqlReturnEntity(sql1);
        //待发货
        String sql2 = "select * from item_order where user_id=" + userId + " and status=0 order by id desc";
        List<ItemOrder> dfh = itemOrderService.listBySqlReturnEntity(sql2);
        //已取消
        String sql3 = "select * from item_order where user_id=" + userId + " and status=1 order by id desc";
        List<ItemOrder> yqx = itemOrderService.listBySqlReturnEntity(sql3);
        //已发货
        String sql4 = "select * from item_order where user_id=" + userId + " and status=2 order by id desc";
        List<ItemOrder> dsh = itemOrderService.listBySqlReturnEntity(sql4);
        //已收货
        String sql5 = "select * from item_order where user_id=" + userId + " and status=3 order by id desc";
        List<ItemOrder> ysh = itemOrderService.listBySqlReturnEntity(sql5);
        model.addAttribute("all", all);
        model.addAttribute("dfh", dfh);
        model.addAttribute("yqx", yqx);
        model.addAttribute("dsh", dsh);
        model.addAttribute("ysh", ysh);
        return "itemOrder/my";
    }

    /**
     * 购物车结算提交
     *
     * @return
     */
    @RequestMapping("/exAdd")
    @ResponseBody
    public String exAdd(@RequestBody List<CarDto> list, HttpServletRequest request) {
        //获取登录用户Id
        Object attribute = request.getSession().getAttribute(Consts.USERID);
        JSONObject js = new JSONObject();
        //如果没有登录转发到登录页面
        if (attribute == null) {
            js.put(Consts.RES, 0);
            return js.toJSONString();
        }
        Integer userId = Integer.valueOf(attribute.toString());
        User byId = userService.getById(userId);
        if (StringUtils.isNullOrEmpty(byId.getAddress())){
            js.put(Consts.RES, 2);
            return js.toJSONString();
        }
        List<Integer> ids = new ArrayList<>();
        BigDecimal to = new BigDecimal(0);
        for (CarDto c : list) {
            ids.add(c.getId());
            Car load = carService.load(c.getId());
            //单价*数量
            to = to.add(new BigDecimal(load.getPrice()).multiply(new BigDecimal( c.getNum())));
        }
        ItemOrder order = new ItemOrder();
        order.setStatus(0);
        order.setCode(getOrderNo());
        order.setIsDelete(0);
        order.setTotal(to.setScale(2,BigDecimal.ROUND_HALF_UP).toString());
        order.setUserId(userId);
        order.setAddTime(new Date());
        itemOrderService.insert(order);

        //订单详情放入orderDetail,删除购物车
        if (!CollectionUtils.isEmpty(ids)) {
            for (CarDto c : list) {
                Car load = carService.load(c.getId());
                OrderDetail de = new OrderDetail();
                de.setItemId(load.getItemId());
                de.setOrderId(order.getId());
                de.setStatus(0);
                de.setNum(c.getNum());
                de.setTotal(String.valueOf(c.getNum() * load.getPrice()));
                orderDetailService.insert(de);
                //修改成交数
                Item load1 = itemService.load(load.getItemId());
                load1.setGmNum(load1.getGmNum() + c.getNum());
                itemService.updateById(load1);
                //删除购物车
                carService.deleteById(c.getId());
            }
        }
        js.put(Consts.RES, 1);
        return js.toJSONString();
    }

    private static String date;
    private static long orderNum = 0L;

    public static synchronized String getOrderNo() {
        String str = new SimpleDateFormat("yyyyMMddHHmm").format(new Date());
        if (date == null || date.equals(str)) {
            date = str;
            orderNum = 0L;
        }
        orderNum++;
        long orderNo = Long.parseLong(date) * 10000;
        orderNo += orderNum;
        return orderNo + "";
    }

    /**
     * 取消订单
     */
    @RequestMapping("/qx")
    public String qx(Integer id,Model model){
        ItemOrder obj = itemOrderService.load(id);
        obj.setStatus(1);
        itemOrderService.updateById(obj);
        model.addAttribute("obj",obj);
        return "redirect:/itemOrder/my";
    }

    /**
     * 后台发货
     */
    @RequestMapping("/fh")
    public String fh(Integer id,Model model){
        ItemOrder obj = itemOrderService.load(id);
        obj.setStatus(2);
        itemOrderService.updateById(obj);
        model.addAttribute("obj",obj);
        return "redirect:/itemOrder/findBySql";
    }

    /**
     * 用户收货
     */
    @RequestMapping("/sh")
    public String sh(Integer id,Model model){
        ItemOrder obj = itemOrderService.load(id);
        obj.setStatus(3);
        itemOrderService.updateById(obj);
        model.addAttribute("obj",obj);
        return "redirect:/itemOrder/my";
    }

    /**
     * 用户评价
     */
    @RequestMapping("/pj")
    public String pj(Integer id,Model model){
        model.addAttribute("id",id);
        return "itemOrder/pj";
    }
}
