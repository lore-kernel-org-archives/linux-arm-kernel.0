From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Wed, 24 Sep 2014 09:56:51 +0200
Subject: [PATCH 09/16] tty: serial: 8250_dma: Add a TX trigger workaround
 for AM33xx
In-Reply-To: <20140922092853.GH20438@ci00147.xsens-tech.local>
References: <5411C810.7070906@linutronix.de>
 <2cf997d9-e7de-465b-915d-3a0a5e7b95f7@email.android.com>
 <54129F6C.7040508@linutronix.de>
 <20140912094010.GE28458@ci00147.xsens-tech.local>
 <5412C21A.8020203@linutronix.de>
 <20140912102816.GF28458@ci00147.xsens-tech.local>
 <541716DC.9020904@linutronix.de>
 <20140917102812.GA20438@ci00147.xsens-tech.local>
 <20140921204100.GA10111@linutronix.de>
 <20140922092853.GH20438@ci00147.xsens-tech.local>
Message-ID: <20140924075651.GC19565@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Frans Klaver | 2014-09-22 11:28:54 [+0200]:

>
>Wow, thanks for your work here. This does indeed sound hard to trap.
>
>I guess then we'd still have to answer the question why the yocto build
>calls set_termios() so often, but that's not on you then. Did you notice
>it even changing settings? We might want to fix this even if the kernel
>should be able to cope.

Yeah. I don't care if this is yocto's fault or not. If it is possible to
stop the DMA transfer from userland with whatever method then it needs to
be fixed in kernel so that this does happen.

>Thanks again,
>Frans

Sebastian
