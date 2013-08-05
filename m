From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Mon, 05 Aug 2013 13:00:34 +0300
Subject: [PATCH] mtd: atmel_nand: fix pmecc selction for ecc requirement
 typo
In-Reply-To: <1372845379-5958-1-git-send-email-josh.wu@atmel.com>
References: <1372845379-5958-1-git-send-email-josh.wu@atmel.com>
Message-ID: <1375696834.14869.422.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-07-03 at 17:56 +0800, Josh Wu wrote:
> Atmel PMECC support 2, 4, 8, 12, 24 bit error correction.
> So if the ecc requirement in ONFI is <= 2, 4, 8, 12, 24.
> We will use 2, 4, 8, 12, 24.
> 
> This patch fix the typo. Use '<=' replace '<'.
> 
> Reported-by: Scott Wood <scottwood@freescale.com>
> Signed-off-by: Josh Wu <josh.wu@atmel.com>

Pushed to l2-mtd.git, thanks!

-- 
Best Regards,
Artem Bityutskiy
