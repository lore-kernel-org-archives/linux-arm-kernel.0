From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 14 Nov 2011 21:20:19 +0000
Subject: [PATCH 1/1] ASoC: mxs-saif: remove function in platform_data
In-Reply-To: <20111111150422.GX16886@pengutronix.de>
References: <1321003740-10992-1-git-send-email-b29396@freescale.com>
 <20111111150422.GX16886@pengutronix.de>
Message-ID: <20111114212018.GA6528@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 11, 2011 at 04:04:22PM +0100, Sascha Hauer wrote:
> On Fri, Nov 11, 2011 at 05:29:00PM +0800, Dong Aisheng wrote:
> > Add master_mode and master_id in platfrom_data since it's board
> > specific and board knows it.
> > Then we can remove the function pointer in platfrom_data to make
> > the driver more devicetree friendly.

> Looks ok. Marc, is it ok when I take this patch? The SoC specific stuff
> for this patch depends on it.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
