From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Mon, 05 Aug 2013 16:04:06 +0300
Subject: [PATCH 1/6] MTD: atmel_nand: use devm_xxx gpio kzalloc, gpio
 and ioremap
In-Reply-To: <1375701279-11495-2-git-send-email-josh.wu@atmel.com>
References: <1375701279-11495-1-git-send-email-josh.wu@atmel.com>
 <1375701279-11495-2-git-send-email-josh.wu@atmel.com>
Message-ID: <1375707846.14869.453.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-08-05 at 19:14 +0800, Josh Wu wrote:
> From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> 
> this will allow to simply the error and remove path
> 
> Cc: linux-mtd at lists.infradead.org
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> [josh.wu at atmel.com: fix checkpatch warnings and rebase to latest mtd git tree]
> [josh.wu at atmel.com: replace devm_request_and_ioremap with devm_ioremap_resource]
> Signed-off-by: Josh Wu <josh.wu@atmel.com>

Pushed to l2-mtd.git. I did not review it much, though, so extra eyes
would not hurt. But it generally looks good.

-- 
Best Regards,
Artem Bityutskiy
