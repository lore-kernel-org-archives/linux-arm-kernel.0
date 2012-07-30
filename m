From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 30 Jul 2012 09:34:54 +0200
Subject: [PATCH] mtd: mxc_nand: Fix compiler warnings
In-Reply-To: <1343466310-14584-1-git-send-email-dirk.behme@gmail.com>
References: <1343466310-14584-1-git-send-email-dirk.behme@gmail.com>
Message-ID: <20120730073454.GI1528@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Sat, Jul 28, 2012 at 11:05:10AM +0200, Dirk Behme wrote:
> From: Dirk Behme <dirk.behme@googlemail.com>
> 
> Fix the compiler warnings
> 
> drivers/mtd/nand/mxc_nand.c:1267: warning: initialization discards qualifiers from pointer target type
> drivers/mtd/nand/mxc_nand.c:1270: warning: initialization discards qualifiers from pointer target type
> drivers/mtd/nand/mxc_nand.c:1273: warning: initialization discards qualifiers from pointer target type
> drivers/mtd/nand/mxc_nand.c:1276: warning: initialization discards qualifiers from pointer target type
These should be gone in next already.

Best regards,
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
