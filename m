From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 18 Oct 2012 11:41:49 +0200
Subject: [PATCH 1/1] MTD: atmel_nand: use devm_xxx gpio kzalloc, gpio
 and ioremap
In-Reply-To: <1350552998.5769.306.camel@sauron.fi.intel.com>
References: <1350129982-12106-1-git-send-email-plagnioj@jcrosoft.com>
 <1350552998.5769.306.camel@sauron.fi.intel.com>
Message-ID: <20121018094149.GF12801@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12:36 Thu 18 Oct     , Artem Bityutskiy wrote:
> On Sat, 2012-10-13 at 14:06 +0200, Jean-Christophe PLAGNIOL-VILLARD
> wrote:
> > this will allow to simply the error and remove path
> > 
> > Cc: linux-mtd at lists.infradead.org
> > Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> > Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> 
> $:~/git/l2-mtd$ git apply --check ~/tmp/jc.mbox
> error: patch failed: drivers/mtd/nand/atmel_nand.c:1420
> error: drivers/mtd/nand/atmel_nand.c: patch does not apply
> 
> Please, send an l2-mtd.git-based version.
> 
> git://git.infradead.org/users/dedekind/l2-mtd-2.6.git
this will have to be merge after pinctrl

it's ok I'll push it via at91

Best Regards,
J.
