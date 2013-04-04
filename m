From: dgilbert@interlog.com (Douglas Gilbert)
Date: Thu, 04 Apr 2013 09:04:15 -0400
Subject: [PATCH] at91sam9260.dtsi: fix u(s)art pinctrl encoding
Message-ID: <515D7A4F.90707@interlog.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A pattern is emerging with sloppy at91 dts(i) files
with pinctrls: the comments are correct and the
corresponding encoding is wrong. The other example that
I fixed was at91sam9x5.dtsi . Makes you wonder how many
people are using this DT stuff in anger ...

This problem was found with AT91SAM9G20 SoCs (Acme's FoxG20).
The attached is against lk 3.9.0-rc5 .

Doug Gilbert
-------------- next part --------------
A non-text attachment was scrubbed...
Name: sam9260_390rc5dg1.patch
Type: text/x-patch
Size: 1443 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130404/fd268187/attachment.bin>
