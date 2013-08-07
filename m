From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Wed, 07 Aug 2013 09:30:59 +0300
Subject: [PATCH] mtd: atmel_nand: fix the warning when CONFIG_OF is not
 defined
In-Reply-To: <1375846569-9499-1-git-send-email-josh.wu@atmel.com>
References: <1375846569-9499-1-git-send-email-josh.wu@atmel.com>
Message-ID: <1375857059.30770.187.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-08-07 at 11:36 +0800, Josh Wu wrote:
> This patch fix following warning:
> 
> drivers/mtd/nand/atmel_nand.c:2007: warning: 'atmel_nand_nfc_match' defined but not used
> 
> This patch add '#if defined(CONFIG_OF)' block to guard around the definition of
> atmel_nand_nfc_match, in order to avoid the warning when kernel is configurated
> as non-dt supported.
> 
> Signed-off-by: Josh Wu <josh.wu@atmel.com>

Pushed to l2-mtd.git, thanks!

-- 
Best Regards,
Artem Bityutskiy
