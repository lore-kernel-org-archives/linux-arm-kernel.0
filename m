From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 14 Jul 2017 14:10:27 +0200
Subject: Back camera working at 1MPix, not working at 5Mpix
Message-ID: <20170714121027.GA31248@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

>From cca v4.6 kernel, I have working back camera in 1Mpix resolution.

I can't get 5Mpix to work at all. In preview mode, display is
distorted in various ways, in raw mode, I get
[  522.576354] omap3isp 480bc000.isp: Unable to stop OMAP3 ISP CCDC
and no data.

If you have recent kernel tree where 5MPix mode works, let me
know. 2.6.x probably does not help me, but 4.x would be interesting. 

BTW my tree with camera is at
kernel.org:pub/scm/linux/kernel/git/pavel/linux-n900.git branch
camera-fw6-2 ... if someone wants to play.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170714/a60d8761/attachment.sig>
