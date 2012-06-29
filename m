From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Fri, 29 Jun 2012 12:09:33 +0300
Subject: [PATCH v12 0/2] MTD: at91: Add PMECC support for at91 nand
 flash driver
In-Reply-To: <4FED6EAB.3000802@atmel.com>
References: <1340871698-477-1-git-send-email-josh.wu@atmel.com>
 <1340898021.3070.123.camel@sauron.fi.intel.com>
 <4FED6EAB.3000802@atmel.com>
Message-ID: <1340960973.3070.136.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-06-29 at 17:00 +0800, Josh Wu wrote:
> > +drivers/mtd/nand/atmel_nand.c:480:32: error: bad constant expression [sparse]
> > +drivers/mtd/nand/atmel_nand.c:488:35: error: bad constant expression [sparse]
> > +drivers/mtd/nand/atmel_nand.c:633:32: error: bad constant expression [sparse]
> > +drivers/mtd/nand/atmel_nand.c:635:35: error: bad constant expression [sparse]
> 
> I use CodeSourcery 2010q1, and no any error reported. So it seems 
> related with the compiler.

They are from sparse, not gcc.

> When I send out the next version of the patch, Could you please test it 
> about above fix? since I don't have Sparse compiler in my hand. Thanks.

I will feed it to aiaiai, but you can also do it easily if you want. You
can download my maintaining scripts from here:
http://git.infradead.org/users/dedekind/maintaining.git
and there is the documentation. You can use aiaiai in general for
checking your patching before submitting out. Catches some embarrassing
errors sometimes :-)

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120629/30dc8c8e/attachment.sig>
