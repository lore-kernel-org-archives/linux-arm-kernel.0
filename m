From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Wed, 06 Jun 2012 16:41:36 +0300
Subject: [PATCH v6] MTD: LPC32xx SLC NAND driver
In-Reply-To: <1338974414-5308-1-git-send-email-stigge@antcom.de>
References: <1338974414-5308-1-git-send-email-stigge@antcom.de>
Message-ID: <1338990096.6875.52.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-06-06 at 11:20 +0200, Roland Stigge wrote:
>  drivers/mtd/nand/lpc32xx_nand_slc.c                   | 1060 ++++++++++++++++++

Can you please rename it to lpc32xx_slc.c? It is already in the "nand"
sub-directory, no need to add "nand" to the file name.

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120606/2bc64097/attachment.sig>
