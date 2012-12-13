From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Thu, 13 Dec 2012 13:41:02 +0200
Subject: [PATCH] mtd: nand: gpmi: reset BCH earlier, too, to avoid NAND
 startup problems
In-Reply-To: <20121212160108.GA2607@pengutronix.de>
References: <1354740362-20412-1-git-send-email-w.sang@pengutronix.de>
 <1355325103.3400.2.camel@sauron.fi.intel.com>
 <20121212160108.GA2607@pengutronix.de>
Message-ID: <1355398862.3400.49.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-12-12 at 17:01 +0100, Wolfram Sang wrote:

> > If you believe this is suitable for stable, please let me know.
> 
> I strongly believe that.

OK, added

Cc: stable at vger.kernel.org

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121213/1ebdd226/attachment.sig>
