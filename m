From: pavel@ucw.cz (Pavel Machek)
Date: Sat, 17 Feb 2018 22:19:27 +0100
Subject: setterm -blank force no longer works after switch to omapdrm
Message-ID: <20180217211927.GC9640@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

I used to have use omap fb driver, and blanking worked as expected. It
no longer works with omap drm driver. (Tested on v4.16-rc1, but I
believe it is broken in older versions, too.)

Can you test it on your hw? Any ideas what could be wrong?

xset dpms force on/off works as expected.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180217/c4f3ddc6/attachment.sig>
