From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 2 Jan 2015 22:50:13 +0000 (UTC)
Subject: [PATCH 2/2] ARM: DRA7xx: hwmod: set DSS submodule parent
 hwmods
In-Reply-To: <1418985914-9027-3-git-send-email-tomi.valkeinen@ti.com>
References: <1418985914-9027-1-git-send-email-tomi.valkeinen@ti.com>
 <1418985914-9027-3-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <alpine.DEB.2.02.1501022250010.27058@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 19 Dec 2014, Tomi Valkeinen wrote:

> Set DSS core hwmod as the parent for all the DSS submodules. This fixes
> the boot time DSS reset, removing the following warnings:
> 
> omap_hwmod: dss_dispc: cannot be enabled for reset (3)
> omap_hwmod: dss_hdmi: cannot be enabled for reset (3)
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

Thanks, queued for v3.19-rc.                         

Note that I cannot test this patch due to lack of a DRA7xx board here.

- Paul
