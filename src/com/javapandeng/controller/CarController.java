package com.javapandeng.controller;

import com.alibaba.fastjson.JSONObject;
import com.javapandeng.po.Car;
import com.javapandeng.po.Item;
import com.javapandeng.service.CarService;
import com.javapandeng.service.ItemService;
import com.javapandeng.utils.Consts;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.persistence.criteria.CriteriaBuilder;
import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.List;

/**
 * 购物车
 *
 * @author 尚郑
 */
@Controller
@RequestMapping("/car")
public class CarController {

    @Autowired
    private CarService carService;

    @Autowired
    private ItemService itemService;

    @RequestMapping("/exAdd")
    @ResponseBody
    public String exAdd(Car car, HttpServletRequest request) {
        JSONObject js = new JSONObject();
        Object attribute = request.getSession().getAttribute(Consts.USERID);
        if (attribute == null) {
            //加入失败
            js.put(Consts.RES, 0);
            //未登录,重定向到登录页面
            return js.toJSONString();
        }
        //加入购物车
        Integer userId = Integer.valueOf(attribute.toString());
        car.setUserId(userId);

        Item item = itemService.load(car.getItemId());
        //获得价格
        String price = item.getPrice();
        Double valueOf = Double.valueOf(price);
        //给购物车中商品单价赋值
        car.setPrice(valueOf);
        //判断是否有折扣
        if (item.getZk() != null) {
            //折扣后商品的单价
            valueOf = valueOf * item.getZk() / 10;
            //保留2位
            BigDecimal bg = new BigDecimal(valueOf).setScale(2, RoundingMode.UP);
            //给购物车中有折扣商品单价赋值
            car.setPrice(bg.doubleValue());
            valueOf = bg.doubleValue();
        }
        //购物车商品的数量
        Integer num = car.getNum();
        Double t = num * valueOf;
        BigDecimal bg = new BigDecimal(valueOf).setScale(2, RoundingMode.UP);
        double doubleValue = bg.doubleValue();
        car.setTotal(doubleValue + "");
        carService.insert(car);
        js.put(Consts.RES, 1);
        return js.toJSONString();
    }

    /**
     * 转向到我的购物车页面
     */
    @RequestMapping("/findBySql")
    public String findBySql(Model model,HttpServletRequest request){
        Object attribute = request.getSession().getAttribute(Consts.USERID);
        if (attribute == null) {
            return "redirect:/login/toLogin";
        }
        Integer userId = Integer.valueOf(attribute.toString());
        String sql = "select * from car where user_id="+userId+" order by id desc";
        List<Car> list = carService.listBySqlReturnEntity(sql);
        model.addAttribute("list",list);
        return "car/car";
    }

    /**
     * 删除购物车
     * @param id
     * @return
     */
    @RequestMapping("/delete")
    @ResponseBody
    public String delete(Integer id){
        carService.deleteById(id);
        return "success";
    }
}
