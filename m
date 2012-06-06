From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Wed, 06 Jun 2012 17:36:30 +0300
Subject: [PATCH v6] MTD: LPC32xx SLC NAND driver
In-Reply-To: <4FCF68DE.6000701@antcom.de>
References: <1338974414-5308-1-git-send-email-stigge@antcom.de>
 <1338989921.6875.50.camel@sauron.fi.intel.com> <4FCF68DE.6000701@antcom.de>
Message-ID: <1338993390.6875.63.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-06-06 at 16:27 +0200, Roland Stigge wrote:
> >> +#else +#define lpc32xx_nand_resume NULL +#define
> >> lpc32xx_nand_suspend NULL +#endif
> > 
> > 0, not NULL.
> 
> Can you please point me to an explanation for this? NULL sounds

Right, sorry, that was incorrect.

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120606/4f302557/attachment.sig>
