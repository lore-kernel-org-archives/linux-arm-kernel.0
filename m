From: linux@rempel-privat.de (Oleksij Rempel)
Date: Fri, 10 Oct 2014 10:42:56 +0200
Subject: preferable method for pinctrl driver
Message-ID: <54379C10.3050004@rempel-privat.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello all,

based on previous experience with clk driver, i know that own research
can be not enough. Before starting to writ pinctrl driver, i would like
to ask your suggestions.

Looks like there is at least two pinctrl driver types:
- imx23 which makes function description insight of DT;
- tegra with function descrption in the source code.
which way is preferable?

Other question, i didn't found exact same HW, do it make sense to merge
this driver with existing one? Are there some similarities with this one?:
http://pastebin.com/hW82Xupq
-- 
Regards,
Oleksij

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 213 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141010/686d4c1a/attachment.sig>
