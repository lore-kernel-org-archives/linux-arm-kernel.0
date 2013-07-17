From: gerlando.falauto@keymile.com (Gerlando Falauto)
Date: Wed, 17 Jul 2013 22:09:07 +0200
Subject: SPARSE_IRQ on Kirkwood
Message-ID: <51E6F9E3.9030302@keymile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

newbie's question: are sparse IRQs [going to be] supported on Kirkwood?
I thought irq domains were pretty much the same thing...
So if I understand correctly, without sparse IRQs I still have to 
increase NR_IRQS within arch/arm/mach-kirkwood/include/mach/irqs.h in 
order to support additional PICs.

Thanks in advance!
Gerlando
