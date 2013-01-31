From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 31 Jan 2013 10:54:46 +0100
Subject: [PATCH 2/2] ARM: imx_v6_v7_defconfig: Add VPU support
In-Reply-To: <20130130130453.GC2757@S2101-09.ap.freescale.net>
References: <1359474553-8949-1-git-send-email-fabio.estevam@freescale.com>
 <1359474553-8949-2-git-send-email-fabio.estevam@freescale.com>
 <20130130130453.GC2757@S2101-09.ap.freescale.net>
Message-ID: <20130131095446.GP1906@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 30, 2013 at 09:04:55PM +0800, Shawn Guo wrote:
> On Tue, Jan 29, 2013 at 01:49:13PM -0200, Fabio Estevam wrote:
> > Let the VPU driver be built by default.
> > 
> Do we have any imx_v6_v7 platform supported by VPU driver today?

Does this matter? IMO it's good to keep the driver in a compilable state
even if it ends up being unused for now.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
