From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 27 Dec 2017 22:05:43 +0100
Subject: v4.15: camera problems on n900
Message-ID: <20171227210543.GA19719@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

In v4.14, back camera on N900 works. On v4.15-rc1.. it works for few
seconds, but then I get repeated oopses.

On v4.15-rc0.5 (commit ed30b147e1f6e396e70a52dbb6c7d66befedd786),
camera does not start.	  

Any ideas what might be wrong there?
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171227/4a951706/attachment.sig>
