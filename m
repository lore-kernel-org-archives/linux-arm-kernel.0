From: mugunthanvnm@ti.com (Mugunthan V N)
Date: Thu, 10 Oct 2013 19:07:54 -0500
Subject: [PATCH 1/2] ARM: OMAP2+: Run make savedefconfig on
 omap2plus_defconfig to shrink it
In-Reply-To: <20131010230440.8152.29871.stgit@localhost>
References: <20131010230325.8152.27727.stgit@localhost>
 <20131010230440.8152.29871.stgit@localhost>
Message-ID: <5257415A.7090600@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 10 October 2013 06:04 PM, Tony Lindgren wrote:
> -CONFIG_TI_DAVINCI_MDIO=y
> -CONFIG_TI_DAVINCI_CPDMA=y
> -CONFIG_TI_CPSW=y
> -CONFIG_AT803X_PHY=y
Can you keep the above defines as AM335x EVM, Beagle bone, Beagle bone
black can use ethernet with omap2plus_defconfig

Regards
Mugunthan V N
