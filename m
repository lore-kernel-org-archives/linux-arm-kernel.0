From: david.lanzendoerfer@o2s.ch (David =?ISO-8859-1?Q?Lanzend=F6rfer?=)
Date: Mon, 28 May 2012 11:00:31 +0200
Subject: Wrong location of omap_writel?
Message-ID: <3426836.dn1rYLBNLa@dizzy-6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

Under linux-next 20120528

I've just found "omap_writel" within "arch/arm/plat-omap/include/plat/usb.h"...
Shouldn't it be located within "arch/arm/plat-omap/include/plat/io.h"?

Just some logical question.
It looks somehow wrong to me...

best regards
	David
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120528/266af70a/attachment.sig>
