From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Fri, 29 Jun 2012 16:04:27 +0300
Subject: [PATCH v10] MTD: LPC32xx MLC NAND driver
In-Reply-To: <CAAAP30HZ1Z5U44wLwSEfcaJSLmVp8AbXPTCagS31hnoCy_tf-g@mail.gmail.com>
References: <1340834129-15545-1-git-send-email-stigge@antcom.de>
 <1340973434.3070.168.camel@sauron.fi.intel.com>
 <CAAAP30HZ1Z5U44wLwSEfcaJSLmVp8AbXPTCagS31hnoCy_tf-g@mail.gmail.com>
Message-ID: <1340975067.3070.180.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-06-29 at 09:56 -0300, Alexandre Pereira da Silva wrote:
> > @@ @@
> > +drivers/mtd/nand/lpc32xx_mlc.c: In function 'lpc32xx_nand_probe':
> > +drivers/mtd/nand/lpc32xx_mlc.c:679:10: warning: variable 'sr' set but not used [-Wunused-but-set-variable]

gcc 4.6, aiaiai uses W=1 when building.

> > +drivers/mtd/nand/lpc32xx_mlc.c:561:24: error: bad constant expression [sparse]

This is sparse, not gcc.

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120629/67cbf2dc/attachment.sig>
