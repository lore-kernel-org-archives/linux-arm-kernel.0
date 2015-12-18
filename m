From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 18 Dec 2015 10:55:41 +0200
Subject: OMAP display kconfig options changing
Message-ID: <5673CA0D.4000706@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

I've just pushed a patch series to fbdev for-next branch which makes the
OMAP DRM and FB drivers independent of each other. This requires
changing the related Kconfig options.

What should I do with omap2plus_defconfig?

At the moment omap2plus_defconfig enables the omapfb driver and panels
as modules. Should I change it to do the same with the new code? Or
should I change it to use omapdrm, which is the better maintained and
developed driver (although no one has probably tried omapdrm on omap2)?

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151218/582ec53b/attachment.sig>
