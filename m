From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 25 Oct 2017 22:34:59 +0200
Subject: 4.13 (and probably all recent) kernels refuse to boot on one Nokia
 N950, work or another
Message-ID: <20171025203459.GA22035@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

...hardware should be identical. 3.5.3-nemo kernel seems to work on
both. 4.13-rc2 with display and clock patches boots on phone "S", but
does not on phone "P"; nothing nothing is received on serial port.

There is some difference in the bootloaders: S's bootloader provides
lots of debug info, P's is silent. R&D settings do _not_ have
influence on bootloader. We know P's serial works, as 3.5.3 kernel
prints "Uncompressing linux...booting" there.

I'll need to return "S" phone and serial cable tommorow. If you have
any ideas, let me know.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171025/e2e4eedf/attachment.sig>
