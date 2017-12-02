From: pavel@ucw.cz (Pavel Machek)
Date: Sat, 2 Dec 2017 11:14:56 +0100
Subject: linux-next on Nokia N900: hang on boot
Message-ID: <20171202101456.GA1810@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

next from 2017-12-01 was tested.

MMC is detected, but then I see wtl4030_bci: .. battery temperature
out of range, and machine halts. This is just before userspace would
be started.

4.15-rc1 seems to work ok on the box.

Any ideas?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171202/ae9b369f/attachment.sig>
