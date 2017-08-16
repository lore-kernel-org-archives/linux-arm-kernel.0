From: tony@atomide.com (Tony Lindgren)
Date: Wed, 16 Aug 2017 08:14:46 -0700
Subject: [PATCH v2 00/10] ARM: dts: Add iodelay data for MMC
In-Reply-To: <20170816134508.8887-1-kishon@ti.com>
References: <20170816134508.8887-1-kishon@ti.com>
Message-ID: <20170816151446.GF8569@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kishon Vijay Abraham I <kishon@ti.com> [170816 06:45]:
> This series only adds data and it won't be used until
> the next series which adds UHS support to omap_hsmmc/sdhci driver.
> 
> Changes from v1:
> *) Add missing Signed-off-by in a couple of patches
> *) Fixed Author of "Move common MMC/SD properties to common file" patch.

Thanks for fixing these, applied and pushed out to
omap-for-v4.14/dt-v3 branch.

Regards,

Tony
