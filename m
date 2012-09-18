From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 18 Sep 2012 16:08:18 +0800
Subject: [PATCH 06/34] ARM: imx: merge plat-mxc into mach-imx
In-Reply-To: <1347860103-4141-7-git-send-email-shawn.guo@linaro.org>
References: <1347860103-4141-1-git-send-email-shawn.guo@linaro.org>
 <1347860103-4141-7-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120918080816.GB6377@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 17, 2012 at 01:34:35PM +0800, Shawn Guo wrote:
> It's really unnecessary to have plat-mxc, and let's merge it into
> mach-imx.  It's pretty much just a bunch of file renaming and
> Kconfig/Makefile merge.
> 
> To make the change less invasive, we keep using Kconfig symbol
> CONFIG_ARCH_MXC for mach-imx sub-architecture.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Will amend the following change into the patch.

Shawn

--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -775,7 +775,6 @@ L:  linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:     Maintained
 T:     git git://git.pengutronix.de/git/imx/linux-2.6.git
 F:     arch/arm/mach-imx/
-F:     arch/arm/plat-mxc/
