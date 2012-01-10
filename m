From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 10 Jan 2012 09:39:22 +0100
Subject: [PATCH 2/4] ASoC: i.MX: Add missing dma_async_issue_pending
In-Reply-To: <20120109161301.GB2974@opensource.wolfsonmicro.com>
References: <1326101570-3716-1-git-send-email-s.hauer@pengutronix.de>
 <1326101570-3716-3-git-send-email-s.hauer@pengutronix.de>
 <20120109161301.GB2974@opensource.wolfsonmicro.com>
Message-ID: <20120110083922.GT5446@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 09, 2012 at 08:13:02AM -0800, Mark Brown wrote:
> On Mon, Jan 09, 2012 at 10:32:48AM +0100, Sascha Hauer wrote:
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> 
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> 
> but I guess I can just apply it immediately?

The ASoC patch (also the mmc driver patch) have to be applied
before the dma driver patches. To make this sure I think it's
best when Vinoud applies the whole series.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
