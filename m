From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 3 May 2018 21:25:10 +0200
Subject: Droid 4: very confusing config around OHCI_OMAP3_HCD
Message-ID: <20180503192510.GB32572@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

For power management experiments, I tried

CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_OMAP3=m
CONFIG_USB_OHCI_HCD_PLATFORM=y

and could not find resulting .ko.

Help text says:

CONFIG_USB_OHCI_HCD_OMAP3:

This option is deprecated now and the driver was removed, use
USB_OHCI_HCD_PLATFORM instead.

Enables support for the on-chip OHCI controller on
OMAP3 and later chips.

Which may partly explain it. But if the option no longer does
anything, why keep it? Certainly second part is confusing if option is
NOP...

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180503/4585a41e/attachment.sig>
