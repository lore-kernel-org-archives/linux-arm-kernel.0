From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 15 Jun 2018 10:00:14 +0200
Subject: Charge counter on droid 4
Message-ID: <20180615080014.GA29192@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

Droid 4 has non-removable battery, yet the charge counter is reset to
near zero on each boot of linux.

Unfortunately, that makes charge counter pretty much useless on d4, as
the "battery full" and "battery empty" limits will be different during
each boot.

Is it possible that we reset the cpcap needlessly, or something like
that?

unicsy_demo (github.com:pavelmachek/unicsy_demo.git) was updated to
read the charge counter, and attempt to estimate battery percentages
from that. Use monitor/batmond... warning -- it provides a _lot_ of
information.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180615/57bfea84/attachment.sig>
