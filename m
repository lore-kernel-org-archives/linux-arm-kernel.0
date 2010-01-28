From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 28 Jan 2010 20:06:44 +0100
Subject: LPC32XX architecture files (updated)
In-Reply-To: <1264643011-17390-1-git-send-email-wellsk40@gmail.com>
References: <1264643011-17390-1-git-send-email-wellsk40@gmail.com>
Message-ID: <20100128190644.GA7765@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

as I read it, the order of the patches could be improved. For example, patches
1-3 check for ARCH_LPC32XX which is only introduced in Patch 4 (which then
includes the Kconfig from the subdir which again is introduced in #5). This
makes bisecting troublesome.

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 197 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100128/3ad14db1/attachment-0001.sig>
