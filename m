From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 03 Dec 2014 21:24:22 +0100
Subject: [PATCH] ARM: pxa: fix lubbock interrupts handling
In-Reply-To: <CAN1soZzZ7nuvvHguaHVHZc8hXvv8SzvWY9Ejf-fYhA5yfbcM-w@mail.gmail.com>
 (Haojian Zhuang's message of "Sat, 29 Nov 2014 00:02:15 +0800")
References: <1417113721-9062-1-git-send-email-robert.jarzmik@free.fr>
 <alpine.DEB.2.11.1411272258010.3961@nanos> <87r3wn1mhu.fsf@free.fr>
 <CAN1soZzZ7nuvvHguaHVHZc8hXvv8SzvWY9Ejf-fYhA5yfbcM-w@mail.gmail.com>
Message-ID: <87r3wgzdl5.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Haojian Zhuang <haojian.zhuang@gmail.com> writes:

>
> I think that it's a kind of irq muxing, just like lots of PMIC (power
> management IC).
> We should move the lubbock board irqs to a mfd driver, and register them as
> threaded irqs.
I will have a look.

I didn't consider mfd for motherboard gates, I'll think of it, thanks for the
idea.

Cheers.

-- 
Robert
