From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sat, 29 Sep 2012 21:53:21 +0200
Subject: [PATCH 01/12] mtd: atmel nand: build regression
In-Reply-To: <1348868177-21205-2-git-send-email-arnd@arndb.de>
References: <1348868177-21205-1-git-send-email-arnd@arndb.de>
 <1348868177-21205-2-git-send-email-arnd@arndb.de>
Message-ID: <20120929195321.GB17667@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23:36 Fri 28 Sep     , Arnd Bergmann wrote:
> The atmel_nand driver was broken by b654a9a46fc2 "mtd: atmel nand: fix
> gpio missing request". This is a rather helpless attempt to fix this,
> probably messing up the error handling even further but getting the
> build to work again, so please treat it as a bug report rather than
> a fix to be applied.
> 
> Without this patch, building any at91 configuration results in:
> 
> drivers/mtd/nand/atmel_nand.c: In function 'atmel_nand_probe':
> drivers/mtd/nand/atmel_nand.c:1451:4: error: label 'err_ecc_ioremap' used but not defined

for the record the error come from the merge of the pmecc and the commit you
mention
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
I already have seach path in my quere from Josh

Best Regards,
J.
