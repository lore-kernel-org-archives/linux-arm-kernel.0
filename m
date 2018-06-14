From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 14 Jun 2018 21:44:49 +0200
Subject: v4.18-rc0: ohci-platform on n900 oops-es on reboot
Message-ID: <20180614194449.GB17808@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

When I enable

CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_OMAP3=y
CONFIG_USB_OHCI_HCD_PLATFORM=y

on n900 (I need it on droid4 and want common config), I get oops when
attempting to reboot the system. I believe problem is there in v4.17,
too.

I'll try to build it as a module and debug, but if you have better
idea, let me know...

Best regards,

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180614/2ece3886/attachment.sig>
