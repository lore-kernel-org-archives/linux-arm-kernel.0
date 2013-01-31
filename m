From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 31 Jan 2013 20:28:51 +0800
Subject: [PATCH 2/2] ARM: imx_v6_v7_defconfig: Add VPU support
In-Reply-To: <20130131095446.GP1906@pengutronix.de>
References: <1359474553-8949-1-git-send-email-fabio.estevam@freescale.com>
 <1359474553-8949-2-git-send-email-fabio.estevam@freescale.com>
 <20130130130453.GC2757@S2101-09.ap.freescale.net>
 <20130131095446.GP1906@pengutronix.de>
Message-ID: <20130131122850.GB2735@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 31, 2013 at 10:54:46AM +0100, Sascha Hauer wrote:
> On Wed, Jan 30, 2013 at 09:04:55PM +0800, Shawn Guo wrote:
> > On Tue, Jan 29, 2013 at 01:49:13PM -0200, Fabio Estevam wrote:
> > > Let the VPU driver be built by default.
> > > 
> > Do we have any imx_v6_v7 platform supported by VPU driver today?
> 
> Does this matter? IMO it's good to keep the driver in a compilable state
> even if it ends up being unused for now.
> 
It's not really necessary since we will have imx_v4_v5_defconfig to
cover it.

Shawn
