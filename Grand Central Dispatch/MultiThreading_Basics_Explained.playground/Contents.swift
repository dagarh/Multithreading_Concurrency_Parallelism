//: Playground - noun: a place where people can play

import UIKit

/*
 
 In iOS, you never create threads or destroy threads manually unlike other languages where we had to create threads. And you also never assign tasks to threads. All this work is done by queues for us here in iOS. We just put tasks on queues by grabing them using DispatchQueue class.
 
 Always remember that you never deal with threads at low level in iOS. And you also never create threads manually in iOS. Apple does this for you behind the scenes. The thing which you deal with, in iOS, is Queue.
 
 https://stackoverflow.com/questions/45109028/difference-between-created-queue-and-global-queue-swift-3
 
 From the above link you can read question and get some sense about queue.
 
 
 You have 5 system queues i.e queues which you can grab from the system. These are already created for you. And you can also create your own queues(serial or concurrent). You deal with queues using DispatchQueue class.
 
 
 You can grab "main queue" which is serial queue and could grab rest "4 global queues"(these are concurrent queues) ---> you can see how to grab these kind of queues online.
 
 
 Dispatch.main , Dispatch.global(), Dispath.global(qos:) --> this is how you get access to queues which will manage thread or threads.
 
 
 You use .sync or .async to put "block of code" or "function" or "task" or "closure" onto queues for execution. And this block of code or task would be executed by a thread. Thread creation and termination is handled by queue itself. Since main queue is serial queue, so it has a single main thread. Global queues are concurrent queues which can create as many threads as they want, based on the tasks or block of codes they need to execute.
 
 
 Since main queue is having only single main thread. If you block this main thread then main queue would be blocked. But in case of global queues if you block any one of the threads then the whole queue is not blocked, only that single thread is blocked. In order to block whole global queue, you need to block all the threads which are inside it executing blocks of code.
 
 
 We have a concept of multi-threading in iOS because multiple threads are executing blocks of code in global queues. And These multiple threads can execute blocks of code (in global queues) in 2 fashion : "Concurrent" fashion or "Parallel" fashion. So concept of "concurrency" means more than one threads executing blocks of code in context switching fashion even if there is one CPU or core available. Concept of "parallelism" means more than one threads executing blocks of code parallel on mutiple cores/CPUs avaiable. So Concurrency and Parallelism are achievable because of multiple threads in global queues.
 
 
 Block of code is run with the help of threads in queues. Thread can only execute a task. Queue is just maintaining the tasks and thread(s). Always remember that when thread is executing some task then it can not leave that task in its mid state and pick other task, this would never happen. Context switching of this thread can happen with another thread but thread never leaves its task in mid state. So threads are used by queues for execution of tasks.
 
 
 Now comes very important concept: when you use ".sync{ }" --> it will "block the queue" on which you are dispatching this block of code and will also block the control of the thread whoever is putting this block of code. So there are two things: blocking of a queue and blocking of thread, which I already explained above. Since ".sync{ }" is blocking the whole queue so that this block of code can be executed at its earliest or quickely. Queue can only resume when this block of code is finished its execution. So if queue is concurrent queue then it can create another thread and then that thread can execute that block of code and after its execution, queue can resume and control thread would also come back and continue executing next line of code. But if queue is serial/main queue then it can not create another thread and hence deadlock would occur. This is how deadlock condition occurs in iOS.
 
 When you use ".async{ }" ---> it will not "block the queue" on which you are dispatching this block of code and will also not block the control of the thread whoever is putting this block of code.
 
 
 We can also create our own private queues ---> could create serial or concurrent queue. And while creating queues manually, you can also specify maximum no of threads which a queue could create. This is how thread explosion would not occur. Check out the links for this.
 
 
 Since we know that multiple threads are executing concurrently or parallely in global queues/private concurrent queues. So multiple problems could arise because of this. One of which is race condition.
 You could read about this and how to fix it here : https://xidazheng.com/2016/10/03/race-conditions-threads-processes-tasks-queues-in-ios/
 That's why we say that if multiple blocks of code sharing some common resource and then multiple threads executing those blocks of code, try to change that common resource then race condition could occur. That's why we always ask that whether this class's methods or variables are thread safe or not. Eg: FileManager's instance methods and variables are thread safe, it means more than one thread can not access those methods. And hence race condition would never occur.
 
 
 Ways to prevent race condition : a) Some of the classes' methods and variables provided by apple are already thread safe, so no problem for those classes. If you have mutiple blocks of code, sharing some common resource then instead of putting them on concurrent queue, you can put them in a serial queue(main or private serial queue), where there is only one thread executing things serially one after another. So race condition would never arise.
 
 
 I will talk about the priority(quality of service) of 4 global queues :
 https://stackoverflow.com/questions/44324595/difference-between-dispatchqueue-main-async-and-dispatchqueue-main-sync
 Check above link for the answer, I would add just few more points to it.
 
 Also watch this stanford video where he explains about the priorities of a queue : https://stackoverflow.com/questions/44324595/difference-between-dispatchqueue-main-async-and-dispatchqueue-main-sync
 
 Sometimes code block in ".userInteractive" queue could also be pulled off by the main queue when it is in quite state. So don't get confused. That may or may not happen.
 
 There is also one ".default" QoS i.e when you get concurrent queue using Dispatch.global()[without specifying quality of service]. Its priority is between ".userInteractive" and ".userInitiated".
 
 
 Don't forget to read the second answer of this link where that cool guy did lot of testing/research, first answer in itself is very informative :
 https://stackoverflow.com/questions/19179358/concurrent-vs-serial-queues-in-gcd
 
 
 This below video is must to watch: https://www.youtube.com/watch?v=YhZahnTiA8U
 So conclusion is : if you want to execute few tasks or blocks of code in order then either use serial queue for that and put blocks of code asynchronouly so that it does not freeze main thread OR use concurrent queue but use ".sync{}" inside ".async{}" to put all those blocks of code on concurrent queue so that it does not freeze main thread. So this is a hack.
 This thing is also mentioned in second answer : https://stackoverflow.com/questions/19179358/concurrent-vs-serial-queues-in-gcd
 
 */
