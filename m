From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 25 Jul 2018 22:02:05 +0200
Subject: Droid 4: suspend to RAM?
Message-ID: <20180725200205.GA29594@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

I have two big problems with droid 4. #1 is that it lost 2 SMS.. and I
have no idea why. Second is power consumption -- it seems to be rather
high even before modem (and thus USB) is enabled.

Interestingly, CyanogenMod and Jolla seem to have higher power
consumption than stock operating system.

(My Linux can survive for 10 hours, stock system could survive for 4
days if I'm not mistaken).

I thought I would experiment with suspend to RAM.. and it indeed
seemed to suspend ok, but I could not wake it up. Do I need to set up
wakeup with button somehow? Is suspend to RAM required for good power
consumption?

Best regards,								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180725/2480d3a3/attachment.sig>
