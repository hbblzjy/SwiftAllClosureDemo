//
//  ViewController.swift
//  SwiftAllClosure
//
//  Created by JasonHao on 2017/7/19.
//  Copyright © 2017年 JasonHao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //创建一个全局的Closure，这是最后应该看的知识点
    //方式一:定义一个闭包变量其实就是定义一个特定函数类型的变量，方式如下。因为Closure变量没有赋初始值，所以我们把其声明为可选类型的变量。在使用时，用!强制打开即可。
    var globalCloure1:((Int, Int) -> Int)?
    
    //方式二：除了上面的方式外，我们还用另一种常用的声明闭包变量的方式。那就是使用关键字typealias定义一个特定函数类型，我们就可以拿着这个类型去声明一个Closure变量了，如下所示
    //定义闭包类型 (就是一个函数类型)
    typealias globalCloure2 = (Int, Int) -> Int
    var myCloure:globalCloure2?

    //全局方法中的Closure
    var globalCloure3:((Int, Int) -> Void)?
    var num11 = Int()
    var num22 = Int()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Swift3.0详细的闭包结构Closure的使用
        /**
         定义格式：
         Closure格式：let/var closure名称:((空／属性，空／属性) -> (空／属性))? 简式：let／var 名称:(() -> ())
         如果没有参数，没有返回值，可以直接写成:()／Void,如果有返回值，可以不加（）,即：let／var 名称:(() -> Int),但是实现的时候最好和定义的格式一样，如closure3
         **/
        
        //111------创建一个无参数、无返回值的Closure
        let closure1:(() -> ())?
//        closure1 = { () -> () in
//            print("这是一个无参数、无返回值的closure")
//        }
        //为空的时候可不写:() -> () in 如下:
        closure1 = {
            print("这是一个无参数、无返回值的closure")
        }
        //调用
        closure1!()
        
        //222------创建一个有参数、无返回值的Closure
        let closure2:((Int,NSString) -> ())?
//        closure2 = { (a:Int,name:NSString) -> () in
//            print("姓名：\(name)，  年龄：\(a)")
//        }
        //为空的时候可不写:-> () 可以忽略 如下:
        closure2 = { (a:Int,name:NSString) in
            print("姓名：\(name)，  年龄：\(a)")
        }
        closure2!(20,"张三李四")
        
        //333------创建一个有参数、有返回值的Closure
        //如果有返回值，不加括号也可以，实现的时候建议和定义的形式一致
//        let closure3:((Int,Int) -> Int)?
//        closure3 = { (a:Int,b:Int) -> Int in
//            return a+b
//        }
//        let sum:Int = closure3!(10,5)
//        print("输出此时Closure3的求和结果：\(sum)")
        //上面两段代码都可以合成一段，1，2同理，但是执行closure的时候不需要再加！强制打开使用
        let closure3:((Int,Int) -> Int) = { (a:Int,b:Int) -> Int in
            return a+b
        }
        let sum:Int = closure3(10,5)
        print("输出此时Closure3的求和结果：\(sum)")
        
        //444------创建一个无参数、有返回值的Closure
        let closure4:(() -> Int) = { () -> Int in
            return 10
        }
        let val:Int = closure4()
        print("输出此时Closure4的返回值：\(val)")
        
        //555------创建和调用 一个全局的Closure
        //方式一：
        globalCloure1 = { (a:Int,b:Int) -> Int in
            return a+b
        }
        print("方式一。。。输出此时全局Closure的和：\(globalCloure1!(2,3))")
        //方式二:
        myCloure = { (a:Int,b:Int) -> Int in
            return a+b
        }
        print("方式二。。。输出此时全局Closure的和：\(myCloure!(2,3))")
        
        //666------创建和调用 带有Closure的方法
        //只有Closure结构一个参数的方法
        self.oneClosure { (a, b) in
            print("只有Closure结构一个参数的方法:后执行方法的调用111。。。a+b的和：\(a+b)")
        }
        //有参数，有一个Closure结构的方法
        self.oneClosure(num1: 2, num2: 3) { (a, b) in
            print("有参数，有一个Closure结构的方法:后执行方法的调用222。。。a+b的和：\(a+b)")
        }
        //有参数，有多个个Closure结构的方法
        self.oneClosure(num1: 2, num2: 3, aClosure: { (a, b) in
            print("有参数，有多个个Closure结构的方法:后执行方法的调用333。。。a+b的和：\(a+b)")
        }) { (c, d) in
            print("有参数，有多个个Closure结构的方法:后执行方法的调用333。。。a*b的积：\(c*d)")
        }
        
        //777------方法中有和全局一样的Closure，如globalCloure3，需要传递方法中的Closure，添加@escaping，即方法执行完以后执行Closure
        self.twoClosure(num1: 2, num2: 3) { (a, b) in
            print("通过全局的Closure传递值:后执行方法的调用777。。。a+b的和：\(a+b)")
        }
        //创建一个UIButton
        let myBtn = UIButton.init(frame: CGRect.init(x: 100, y: 100, width: 100, height: 100))
        myBtn.setTitle("Click me", for: .normal)
        myBtn.backgroundColor = UIColor.cyan
        myBtn.setTitleColor(UIColor.red, for: .normal)
        myBtn.addTarget(self, action: #selector(myBtnClick(btn:)), for: .touchUpInside)
        self.view.addSubview(myBtn)
        
        //888------使用@autoclosure描述的Closure
        self.autoclosure(a: 2, b: 3, num: (3>2))
        
    }
    //MARK:666------创建和调用 带有Closure的方法
    //只有Closure结构一个参数的方法
    func oneClosure(aClosure:((Int,Int) -> ())) {
        print("只有Closure结构一个参数的方法:先执行这个方法。。。。111")
        aClosure(2,3)
    }
    //有参数，有一个Closure结构的方法
    func oneClosure(num1:Int,num2:Int,aClosure:((Int,Int) -> ())) {
        print("有参数，有一个Closure结构的方法:先执行这个方法。。。。。222")
        aClosure(num1,num2)
    }
    //有参数，有多个个Closure结构的方法
    func oneClosure(num1:Int,num2:Int,aClosure:((Int,Int) -> ()),bClosure:((Int,Int) -> Void)) {
        print("有参数，有多个个Closure结构的方法:先执行这个方法。。。。。333")
        aClosure(num1,num2)
        bClosure(num1,num2)
    }
    
    //MARK:777-----方法中有和全局一样的Closure，如globalCloure3，需要传递方法中的Closure
    /**
     **注意：
     如果需要赋值给全局Closure时需要加@escaping修饰方法中的闭包参数，如果不加系统会提示你加上，因为这种情况默认你是在方法结束后执行的Closure
     解释如下：
     在以前版本闭包的使用时不用加@escaping的。当前版本，如果闭包没有回调Closure参数返回值，是不需要@escaping的。但是如果闭包传递了Closure参数，就会出现一种假设。那就是closure的内容会在函数执行返回后才完成。
     简单的说就是如果这个闭包是在这个函数结束前被调用，就是@noescape。
     闭包在函数执行完成后才调用，调用的地方超过了函数的范围，就是@escaping逃逸闭包。
     网络请求后结束的回调就是逃逸的。因为发起请求后过一段时间闭包执行。
     在swift3.0中所有闭包都是默认非逃逸的，无需@noescape。如果是逃逸的就@escaping表示。
     延迟操作，网络加载等都需要@escaping。
     **/
    func twoClosure(num1:Int,num2:Int,aClosure:@escaping ((Int,Int) -> ())) {
        print("有全局Closure结构的方法:先执行这个方法。。。。。777")
        num11 = num1
        num22 = num2
        globalCloure3 = aClosure
    }
    //按钮点击方法
    func myBtnClick(btn:UIButton) {
        if (globalCloure3 != nil) {
            globalCloure3!(num11,num22)
        }
    }
    
    //MARK:888------Closure中的@autoclosure其实就是省略了最外围的（）,把后面的语句自动的封装成一个闭包:
    //只适用于无参数，有返回值的格式
    //num:(() -> Bool) -----> num: @autoclosure () -> Bool
    func autoclosure(a:Int,b:Int, num: @autoclosure () -> Bool){
        if num() {
            print("true")
        }else{
            print("false")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

