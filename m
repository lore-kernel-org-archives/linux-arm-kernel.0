From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 10 Aug 2018 12:45:58 +0200
Subject: Droid 4: poweroff reboots the machine
Message-ID: <20180810104558.GA5198@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On droid4, "sudo poweroff" reboots the system... which is not exactly
welcome, because mainline kernel will discharge the battery in 10
hours.

I learned to reboot into stock Motorola Android (lasts few days), but
that takes some clicking; easier solution is powering it off in
SafeStrap ... which thankfully works.

But those are workarounds, if someone knows how to debug/fix it, let
me know.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180810/285a4e75/attachment.sig>
