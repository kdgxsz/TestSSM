package com.javapandeng.controller;

import com.javapandeng.base.BaseController;
import com.javapandeng.po.ItemCategory;
import com.javapandeng.po.User;
import com.javapandeng.service.UserService;
import com.javapandeng.utils.Consts;
import com.javapandeng.utils.Pager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

/**
 * 用户层
 *
 * @author 尚郑
 */
@Controller
@RequestMapping("/user")
public class UserController extends BaseController {

    @Autowired
    private UserService userService;

    /**
     * 管理员通过关键字模糊查询用户
     * @param model
     * @param user
     * @return
     */
    @RequestMapping("/findBySql")
    public String findBySql(Model model, User user) {
        String sql = "select * from user where 1=1 ";

        if (!isEmpty(user.getUserName())) {
            sql += " and userName like '%" + user.getUserName() + "%'";
        }
        sql += " order by id";
        Pager<User> pagers = userService.findBySqlRerturnEntity(sql);
        model.addAttribute("pagers", pagers);
        model.addAttribute("obj",user);
        return "user/user";
    }

    /**
     * 管理员跳转到添加用户页面
     * @return
     */
    @RequestMapping("/add")
    public String add(){
        return "user/add";
    }

    /**
     * 管理员添加用户保存功能
     * @param user
     * @return
     */
    @RequestMapping("/exAdd")
    public String exAdd(User user) {
        userService.insert(user);
        return "redirect:/user/findBySql.action";
    }

    /**
     * 管理员操作转向到修改用户页面
     */
    @RequestMapping("/update")
    public String update(Integer id, Model model) {
        User obj = userService.load(id);
        model.addAttribute("obj", obj);
        return "user/update";
    }

    /**
     * 管理员修改用户
     */
    @RequestMapping("/exUpdate")
    public String exUpdate(User user) {
        userService.updateById(user);
        return "redirect:/user/findBySql.action";
    }

    /**
     * 管理员删除用户
     */
    @RequestMapping("/delete")
    public String delete(Integer id) {
        String sql = "delete from user where id="+id;
        userService.updateBysql(sql);
        return "redirect:/user/findBySql.action";
    }

    /**
     * 普通用户查看用户信息
     * @param model
     * @param request
     * @return
     */
    @RequestMapping("/view")
    public String view(Model model, HttpServletRequest request){
        //获取登录用户Id
        Object attribute = request.getSession().getAttribute(Consts.USERID);
        //如果没有登录转发到登录页面
        if(attribute==null){
            return "redirect:/login/uLogin";
        }
        Integer userId =Integer.valueOf(attribute.toString());
        //通过用户id查出用户实体
        User obj = userService.load(userId);
        //存入视图层用于显示
        model.addAttribute("obj",obj);
        //返回到用户视图层
        return "user/view";
    }

    /**
     * 普通用户修改个人信息
     * @param user
     * @param request
     * @return
     */
    @RequestMapping("/uexUpdate")
    public String uexUpdate(User user,HttpServletRequest request) {
        //获取登录用户Id
        Object attribute = request.getSession().getAttribute(Consts.USERID);
        //如果没有登录转发到登录页面
        if(attribute==null){
            return "redirect:/login/uLogin";
        }
        user.setId(Integer.valueOf(attribute.toString()));
        userService.updateById(user);
        return "redirect:/user/view.action";
    }


}
