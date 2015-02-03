From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Tue, 3 Feb 2015 14:47:52 +0100
Subject: [PATCH] ARM: berlin: add a defconfig
In-Reply-To: <3962783.sVjmOB1hYm@wuerfel>
References: <1422962932-12603-1-git-send-email-antoine.tenart@free-electrons.com>
 <3962783.sVjmOB1hYm@wuerfel>
Message-ID: <20150203134752.GA12908@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Tue, Feb 03, 2015 at 01:54:42PM +0100, Arnd Bergmann wrote:
> On Tuesday 03 February 2015 12:28:52 Antoine Tenart wrote:
> > Marvell Berlin SoCs did not have a custom defconfig and were only
> > supported in multi_v7_defconfig.
> > 
> > Adds a proper defconfig, allowing to boot a Berlin SoC with all the
> > currently supported features: SMP, Pinmux, AHCI, Ethernet, I2C, GPIO,
> > USB, SDHCI.
> > 
> > 
> 
> Are there any features that are not currently supported by
> multi_v7_defconfig? If so, please also add them there as
> loadable modules.

I just checked and it seems some of them are missing:
- pxa168 ethernet support
- Berlin USB PHY support
- Berlin SATA PHY support

I'll cook up a patch to add these 3 features into multi_v7_defconfig.

Thanks!

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
