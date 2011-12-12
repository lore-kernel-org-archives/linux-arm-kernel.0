From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 12 Dec 2011 18:07:09 +0800
Subject: [GIT PULL] imx: gpio interrupt cleanup
In-Reply-To: <20111208143204.GA8139@S2100-06.ap.freescale.net>
References: <20111208143204.GA8139@S2100-06.ap.freescale.net>
Message-ID: <20111212100707.GJ9572@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please hold this request.  I'm trying to make this series cope with
the Rob's series adding irqdomain support for irq_chip_generic, since
both imx tzic and gpio interrupt controllers are irq_chip_generic users.

Regards,
Shawn

On Thu, Dec 08, 2011 at 10:32:05PM +0800, Shawn Guo wrote:
> Hi Arnd and  Olof,
> 
> Please consider to pull the series below.  I really should have
> Thomas' ack on Jamie's patch 'irqdomain: export irq_domain_simple_ops
> for !CONFIG_OF', and Grant's ack on patch 'gpio/mxc: adopt irq_domain
> in gpio driver'.  So this pull request is also asking comments for the
> path of these patches.
> 
> Thomas, Grant,
> 
> Please speak up if you do not want "your" patches to go through arm-soc
> tree.  Thanks.
> 
> Shawn
> 
> The following changes since commit fec607aab5dca019cfc76768fa0b5908d47a55b1:
> 
>   Merge branch 'imx/fix-irqdomain' of git://git.linaro.org/people/shawnguo/linux-2.6 into fixes (2011-12-06 14:15:02 +0000)
> 
> are available in the git repository at:
> 
>   git://git.linaro.org/people/shawnguo/linux-2.6.git imx/clean-gpio-irq
> 
> Jamie Iles (1):
>       irqdomain: export irq_domain_simple_ops for !CONFIG_OF
> 
> Shawn Guo (5):
>       arm/imx: eliminate macro IMX_GPIO_TO_IRQ()
>       arm/imx: eliminate macro IOMUX_TO_IRQ()
>       arm/imx: eliminate macro IRQ_GPIOx()
>       gpio/mxc: adopt irq_domain in gpio driver
>       arm/imx: remove macro MXC_GPIO_IRQ_START
