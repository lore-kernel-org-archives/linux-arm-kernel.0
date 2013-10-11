From: tony@atomide.com (Tony Lindgren)
Date: Thu, 10 Oct 2013 17:44:11 -0700
Subject: [PATCH 1/2] ARM: OMAP2+: Run make savedefconfig on
 omap2plus_defconfig to shrink it
In-Reply-To: <5257415A.7090600@ti.com>
References: <20131010230325.8152.27727.stgit@localhost>
 <20131010230440.8152.29871.stgit@localhost>
 <5257415A.7090600@ti.com>
Message-ID: <20131011004411.GL29913@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Mugunthan V N <mugunthanvnm@ti.com> [131010 17:15]:
> On Thursday 10 October 2013 06:04 PM, Tony Lindgren wrote:
> > -CONFIG_TI_DAVINCI_MDIO=y
> > -CONFIG_TI_DAVINCI_CPDMA=y
> > -CONFIG_TI_CPSW=y
> > -CONFIG_AT803X_PHY=y
> Can you keep the above defines as AM335x EVM, Beagle bone, Beagle bone
> black can use ethernet with omap2plus_defconfig

I think they should get automatically selected by
default with make omap2plus_defconfig, I don't think make
savedefconfig removes any selected features.

Maybe check it though with this patch?

Regards,

Tony
