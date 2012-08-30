From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 30 Aug 2012 10:25:18 +0200
Subject: MX28 & finding out boot mode
Message-ID: <20120830082518.GA27306@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

is there a way to find out how the MX28 was booted? I could read out the
bootmode-pins for indication. Still, either by button or by empty NAND,
the CPU could have been booted via USB recovery mode. And going through
the docs and the bootlets code, I can't find a way to determine if USB
recovery was used.

So, can USB recovery mode be detected somehow? Then, this and reading
pins should be sufficent, no?

Thanks,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120830/b1553e27/attachment.sig>
