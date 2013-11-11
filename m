From: gerlando.falauto@keymile.com (Gerlando Falauto)
Date: Mon, 11 Nov 2013 15:45:31 +0100
Subject: SPARSE_IRQ on Kirkwood
In-Reply-To: <51E6F9E3.9030302@keymile.com>
References: <51E6F9E3.9030302@keymile.com>
Message-ID: <5280ED8B.5060206@keymile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

a few months later, my understanding has not changed much... could 
anyone please shed some light?

Thanks!
Gerlando

On 07/17/2013 10:09 PM, Gerlando Falauto wrote:
> Hi everyone,
>
> newbie's question: are sparse IRQs [going to be] supported on Kirkwood?
> I thought irq domains were pretty much the same thing...
> So if I understand correctly, without sparse IRQs I still have to
> increase NR_IRQS within arch/arm/mach-kirkwood/include/mach/irqs.h in
> order to support additional PICs.
>
> Thanks in advance!
> Gerlando
>
