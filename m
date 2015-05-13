From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 13 May 2015 10:24:13 +0200
Subject: [PATCH v3 4/4] mtd: mxc_nand: generate nand_ecclayout for 8 bit
 ECC
In-Reply-To: <95e2a17d74da5a0415ab93e060f6efc681216313.1431504091.git.baruch@tkos.co.il>
References: <cover.1431504091.git.baruch@tkos.co.il>
 <95e2a17d74da5a0415ab93e060f6efc681216313.1431504091.git.baruch@tkos.co.il>
Message-ID: <20150513082413.GL28888@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 13, 2015 at 11:17:39AM +0300, Baruch Siach wrote:
> Hardware 8 bit ECC requires a different nand_ecclayout. Instead of adding yet
> another static struct nand_ecclayout, generate it in code.
> 
> Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
