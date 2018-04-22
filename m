From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 22 Apr 2018 09:42:13 +0200
Subject: v4.17-rc1: regressions on N900, N950
Message-ID: <20180422074213.GA12428@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

v4.17-rc1 broke display for me on Nokia N900. (I don't know if system
boots, but I can see on red flash LED that at least that driver
succeeded. So it should not be early boot crash).

v4.17-rc1 also broke boot on N950.

Any ideas? Does it work for you?
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180422/17e0d71c/attachment.sig>
