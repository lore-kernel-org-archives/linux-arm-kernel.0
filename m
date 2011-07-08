From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 8 Jul 2011 19:06:16 +0200
Subject: [RFC] dmaengine: Moving TI SDMA driver to dmaengine - design plan
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E94030259CD17@dbde02.ent.ti.com>
References: <E0D41E29EB0DAC4E9F3FF173962E9E94030259CD17@dbde02.ent.ti.com>
Message-ID: <CACRpkdYF6Z7CxhZVvuT8V+ENRd6K0q7=uhk93kOaOG-W3AvoTw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 8, 2011 at 10:22 AM, Raju, Sundaram <sundaram@ti.com> wrote:

> I would like to follow the Freescale i.MX DMA driver model,
> where imx-dma.c in drivers/dma which implements all the
> dmaengine hooks, internally uses the APIs in dma-v1.c file in
> arch/arm/mach-imx. All APIs in dma-v1.c are also exported
> out for direct use by clients.
>(...)
> Let me know your thoughts.

Sounds like a plan, just do it.
I think Samsung are currently using the scheme to migrate to
dmaengine as well.

Thanks,
Linus Walleij
