From: miloody@gmail.com (loody)
Date: Sat, 16 Nov 2013 00:55:11 +0800
Subject: Some question about GIC v1 setting
Message-ID: <CANudz+sg6MiUZaTELF4G=NMfwj--K9j10JrYh1cm2VAjfvq6MA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi all:
I use arm cortex A9 smp with GIC v1 system.
And my kernel is 3.8.13.

I have some questions:
1.  From GIc v1 spec, we can modify irq priority.
     (ICDIPRn, Interrupt Priority Rigisters)
     how could we do that in kernel? Did kernel provide any API of Irq
to reach that goal?

2. From Gic V1 spec, we can assign 1 irq to multi-core.
     (ICDIPTRn, Interrupt Processor Targets Registers)
     Is there similar API in kernel to let 1 irq possibility to be
handled by multi-cores?

Appreciate your help in advance,
