JS在任务(Task)中的使用
==

如果你对IOT-Tree的任务机制还不了解，请参考[项目任务][task]。

IOT-Tree在任务活动Action中，对JS脚本进行了划分，如下图：

<img src="../img/main/m023.png" />

可以看到，每个活动内部会有三个脚本划分:"init script","run in loop script","end script"。他们分别对应"初始化脚本","在循环中重复运行脚本","运行结束脚本"。

>初始化脚本init script:在任务启动时，只运行一次，你可以在里面定义初始化变量，一些后续需要的JS函数声明。

>在循环中重复运行脚本run in loop script:这个JS脚本，在任务运行期间，根据任务设定的运行时间间隔，会被重复运行。

>运行结束脚本end script:在任务正常停止时，会被运行一次的脚步，你可以对此进行善后工作。

每个活动的这三个部分JS脚本，你可以根据需要点击编辑即可，当然如果某个部分你没有设定任何脚本，那么等于不起作用。

本文接下来对这三个JS脚本划分做详细说明。

[task]:../main/task.md

## 1 任务脚本运行上下文$prj

IOT-Tree当前规定，一个项目中的所有任务JS脚本，运行上下文(Context)都是项目根部。也就是说，JS可以调用整个项目下的所有对JS开放的内容。

_注：不排除以后会在项目树中，增加和任务类似的控制逻辑。如：针对某个设备节点，专门定义内部控制逻辑，这样一些通用控制逻辑也会随着节点的重用而重用_

## 2 init script编写说明

## 3 run in loop script编写说明

## 4 end script编写说明

