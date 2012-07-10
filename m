From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 10 Jul 2012 12:01:56 +0800
Subject: [PATCH 4/7] ARM: mxs: convert apx4devkit board to device tree
In-Reply-To: <4FFAF5A9.9050007@bluegiga.com>
References: <1341814496-17487-1-git-send-email-shawn.guo@linaro.org>
 <1341814496-17487-5-git-send-email-shawn.guo@linaro.org>
 <4FFAF5A9.9050007@bluegiga.com>
Message-ID: <20120710040154.GB19649@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 09, 2012 at 06:15:53PM +0300, Lauri Hintsala wrote:
> On 07/09/2012 09:14 AM, Shawn Guo wrote:
> >Cc: Lauri Hintsala <lauri.hintsala@bluegiga.com>
> >Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> >---
> >  arch/arm/boot/dts/apx4devkit.dts |  143 ++++++++++++++++++++++++++++++++++++++
> >  arch/arm/boot/dts/imx28.dtsi     |   33 +++++++++
> >  arch/arm/mach-mxs/mach-mxs.c     |   23 ++++++
> >  3 files changed, 199 insertions(+), 0 deletions(-)
> >  create mode 100644 arch/arm/boot/dts/apx4devkit.dts
> 
> Apx4devkit boots up and works fine with DT. I would like to add
> support for NAND, display, SSP2, etc... I'll send patches tomorrow.
> 
Thanks, Lauri.  Can I add your Tested-by?

-- 
Regards,
Shawn
