From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 14 Jan 2011 09:27:51 +0100
Subject: [PATCH] ARM mxs: clkdev related compile fixes
In-Reply-To: <1294934365-17087-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20101117090635.GF12959@game.jcrosoft.org>
	<1294934365-17087-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20110114082751.GN16391@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16:59 Thu 13 Jan     , Uwe Kleine-K?nig wrote:
> From: Sascha Hauer <s.hauer@pengutronix.de>
> 
> Since commit
> 
> 	6d803ba (ARM: 6483/1: arm & sh: factorised duplicated clkdev.c)
> 
> platforms need to select CLKDEV_LOOKUP instead of COMMON_CLKDEV and need
> to include <linux/clkdev.h>.
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> 
> Cc: Shawn Guo <shawn.guo@freescale.com>
> Cc: Lothar Wa?mann <LW@KARO-electronics.de>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> [ukl: make commit log more verbose; remove selection of COMMON_CLKDEV]
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Best Regards,
J.
