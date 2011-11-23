From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 23 Nov 2011 21:15:05 +0000
Subject: [GIT PULL] ARM: pxa: change gpio to platform driver
In-Reply-To: <CAN1soZw6JuNsty91xQP2G4NLodAz5GfOVUO7xYo+fdx8u0chvg@mail.gmail.com>
References: <CAN1soZw6JuNsty91xQP2G4NLodAz5GfOVUO7xYo+fdx8u0chvg@mail.gmail.com>
Message-ID: <201111232115.05818.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 15 November 2011, Haojian Zhuang wrote:
> The following changes since commit 31555213f03bca37d2c02e10946296052f4ecfcd:
> 
>   Revert "hvc_console: display printk messages on console."
> (2011-11-06 22:22:16 -0800)
> 
> are available in the git repository at:
>   git://github.com/hzhuang1/linux.git gpio
> 
> Haojian Zhuang (11):
>       ARM: pxa: rename IRQ_GPIO to PXA_GPIO_TO_IRQ
>       ARM: pxa: use chained interrupt for GPIO0 and GPIO1
>       ARM: pxa: rename gpio_to_irq and irq_to_gpio
>       ARM: pxa: recognize gpio number and type
>       ARM: pxa: rename NR_BUILTIN_GPIO
>       ARM: pxa: use little endian read write in gpio driver
>       ARM: pxa: use generic gpio operation instead of gpio register
>       ARM: pxa: change gpio to platform device
>       ARM: mmp: clear gpio edge detect
>       ARM: pxa: add clk support in gpio driver
>       driver: pcmcia: replace IRQ_GPIO() with gpio_to_irq()

Sorry for the long delay. I needed time to settle back in after my vacation
at arrange with the git tree being shared and on kernel.org now.

I've pulled it into the drivers/pxa-gpio branch of arm-soc and plan to
submit it as part of the next/drivers branch in the next merge window.

	Arnd
