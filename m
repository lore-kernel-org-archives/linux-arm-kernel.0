From: tony@atomide.com (Tony Lindgren)
Date: Wed, 4 Dec 2013 09:53:10 -0800
Subject: [PATCH 0/3] ARM: OMAP2+: Remove remaining unused legacy code
In-Reply-To: <1385752697-13700-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1385752697-13700-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <20131204175310.GR26766@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Javier Martinez Canillas <javier.martinez@collabora.co.uk> [131129 11:20]:
> Now that OMAP2+ board files are scheduled for removal for v3.14
> there is unused code that was only used by legacy platform code
> and can be removed.
> 
> This patch-set depends on the series:
> 
> [PATCH 00/12] Drop omap3 board files and make mach-omap2 boot in DT only mode
> 
> and is composed of the following patches:
> 
> [PATCH 1/3] ARM: OMAP2+: Remove legacy smsc911x and smc91x GPMC
> [PATCH 2/3] ARM: OMAP2+: Remove unnecesary include in GPMC driver
> [PATCH 3/3] ARM: OMAP2+: Remove legacy board-flash.c

Thanks looks good to me. I'll wait for -rc3 to get tagged and then
apply all the pending mach-omap2 device tree conversion patches
against it including these.

Regards,

Tony
