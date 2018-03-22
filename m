From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 22 Mar 2018 13:35:18 +0100
Subject: v4.16-rc5 on Motorola Droid 4
Message-ID: <20180322123518.GA27004@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

Just... I got recent mainline to work on Motorola Droid 4. (Thanks for
all the help).

Tree is at kernel.org:

kernel.org:pub/scm/linux/kernel/git/pavel/linux-n900.git all-v4.16:all-v4.16

branch all-v4.16 contains config.4 (which is config I'm using) and the
patches I used. (But I did not do anything special).

What does _not_ yet work is battery charging, and I'm not sure if the
phone will actually shut down itself or if it will drain & damage the
battery.

user at devuan:/my/unicsy_demo$ lib/hardware.py
Battery 3.67V 3.67V 3.82V 15% 49% 0% 0/0 mAh Discharging -353/-1/-1 mA
user at devuan:/my/unicsy_demo$ lib/hardware.py
Battery 3.65V 3.65V 3.88V 15% 61% 0% 0/0 mAh Discharging -534/-1/-1 mA

Usb networking works with that config, and I can boot useful system
with maemo leste.

Good luck,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180322/7b95b086/attachment.sig>
