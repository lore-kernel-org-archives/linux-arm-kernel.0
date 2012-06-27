From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Wed, 27 Jun 2012 15:33:12 +0300
Subject: [PATCH v7] MTD: LPC32xx SLC NAND driver
In-Reply-To: <4FEAF90B.5030809@antcom.de>
References: <1339064536-20553-1-git-send-email-stigge@antcom.de>
 <1340794007.29342.50.camel@sauron.fi.intel.com>
 <4FEAF90B.5030809@antcom.de>
Message-ID: <1340800392.1799.17.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-06-27 at 14:14 +0200, Roland Stigge wrote:
> Thanks for the note! I'm sending an incremental patch. There was
> actually only one place in the two functions that could fail (return
> code of lpc32xx_xfer()).

Could you please check the MCL patch as well and re-send it against the
l2 tree?

I've squashed your change into the driver and pushed out, thanks!

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120627/c87a426c/attachment.sig>
