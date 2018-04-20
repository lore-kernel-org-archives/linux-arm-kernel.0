From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 20 Apr 2018 09:40:36 +0200
Subject: bq27000: directory/files exists even when hardware is not available
Message-ID: <20180420074036.GA16257@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On droid4 (4.17-rc1), /sys/class/power_supply/bq27000-battery exists
even when hardware is not present (as on Droid 4).

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180420/f3681b8e/attachment.sig>
