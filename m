From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 18 Mar 2018 23:04:18 +0100
Subject: 4.16-rc5 on Motorola Droid 4
Message-ID: <20180318220418.GA22880@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

I have the phone, I have safestrap installed, kexec seems to work
(crashes my system). But I can't get any output from the new kernel.

All the howtos assume serial connection, but I don't yet have
that. I'm really bad at soldering. IIRC display should work in the
latest kernels, maybe with some patches?

Could someone give me .config and git hash that works for him? Once I
get working display I should be able to continue easily. I'd really
like to get voice calls working...

I took a brief look through dts, and I did not find anything that
could be easily used for debugging. (It seems that capslock LED and
keyboard backlight is not yet supported? Also volume down  seems to be
supported but not volume up, funny).

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180318/b5c348d3/attachment.sig>
