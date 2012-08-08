From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 8 Aug 2012 14:27:41 +0100
Subject: [PATCH 0/4] ASoC/OMAP: ASoC machine driver for simple SoC with
 twl4030
In-Reply-To: <1344419650-5389-1-git-send-email-peter.ujfalusi@ti.com>
References: <1344419650-5389-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20120808132741.GX16861@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 08, 2012 at 12:54:06PM +0300, Peter Ujfalusi wrote:

> Changes under arch/arm/mach-omap2/ are trivial, I don't expect merge issues
> later. If it is OK for the maintainers I would like this to go via audio tree
> (with the McBSP and the twl4030-audio stack DT support).

This all looks OK to me, again if it gets applied via ASoC I'll put it
on a separate branch so if we do need to get into OMAP as well it's easy
to do so.
