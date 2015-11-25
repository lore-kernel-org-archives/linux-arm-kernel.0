From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Nov 2015 23:44:58 +0100
Subject: [GIT PULL] ARM: imx: fixes for 4.4
In-Reply-To: <20151125132517.GI11999@tiger>
References: <20151125132517.GI11999@tiger>
Message-ID: <2722757.cJD6BEsQUF@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 25 November 2015 21:25:17 Shawn Guo wrote:
> The i.MX fixes for 4.4:
> - Add missing .irq_set_type for i.MX GPC irq_chip.  It fixes an issue
>   that device IRQ type setting doesn't match the one specified in device
>   tree, since stacked IRQ domain is adopted in GPC driver.
> - Fix the wrong spi-num-chipselects settings for Vybrid DSPI devices.
> - Fix a merge error in Vybrid dts regarding to ADC device property
>   fsl,adck-max-frequency
> 
> 

Pulled into fixes, thanks!

	Arnd
