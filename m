From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Sat, 12 Dec 2015 10:29:55 +0200
Subject: [4.1.3-rt3] [report][suspend to ram] BUG: sleeping function
 called from invalid context at kernel/locking/rtmutex.c:917
In-Reply-To: <20151211162008.GB6720@linutronix.de>
References: <55CB8FAE.9020309@ti.com> <20150816114241.GC7004@linutronix.de>
 <55D201DC.5070604@ti.com> <55E9CAFB.9070002@ti.com>
 <20151211162008.GB6720@linutronix.de>
Message-ID: <566BDB03.3040100@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/11/2015 06:20 PM, Sebastian Andrzej Siewior wrote:
> * Grygorii Strashko | 2015-09-04 19:46:51 [+0300]:
>
>> Hi All,
> Hi,
>
>> I'd very appreciated for comments.
>
> did you run into any problems with this or is it working for you?
>

No. And corresponding patch was merged in v4.1.7-rt8
9754cf6 ARM: smp: Move clear_tasks_mm_cpumask() call to __cpu_die()


-- 
regards,
-grygorii
