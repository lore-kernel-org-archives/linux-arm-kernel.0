From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Sun, 23 Sep 2012 16:01:49 +0300
Subject: [PATCH v2] mtd: atmel_nand: fix the compile error which miss
 label "err_ecc_ioremap".
In-Reply-To: <1348404075.1889.1.camel@kyv>
References: <1347347412-24214-1-git-send-email-josh.wu@atmel.com>
 <1348404075.1889.1.camel@kyv>
Message-ID: <1348405309.1889.3.camel@kyv>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2012-09-23 at 15:41 +0300, Artem Bityutskiy wrote:
> On Tue, 2012-09-11 at 15:10 +0800, Josh Wu wrote:
> > Add err_ecc_ioremap label to fix following errors:
> > ---8<--- 
> >   CC      drivers/mtd/nand/atmel_nand.o
> > drivers/mtd/nand/atmel_nand.c: In function 'atmel_nand_probe':
> > drivers/mtd/nand/atmel_nand.c:1423: error: label 'err_ecc_ioremap' used but not defined
> > make[3]: *** [drivers/mtd/nand/atmel_nand.o] Error 1
> > make[2]: *** [drivers/mtd/nand] Error 2
> > make[1]: *** [drivers/mtd] Error 2
> > make: *** [drivers] Error 2
> > --->8---
> 
> Pushed to l2-mtd.git, thanks!

Actually squashed it into the bogus patch.

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120923/d7f838a4/attachment.sig>
