From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 22 Apr 2018 10:36:40 +0200
Subject: FM radio on Droid 4 (in v4.17-rc1)
Message-ID: <20180422083640.GA23303@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

This is my first attempt at setting up FM radio on Droid
4. Unfortunately I get:

[   29.614959] power_supply usb: uevent: failed to send synthetic
uevent
[   32.678100] (stc): gdata/new_proto/recv or reg_complete_cb not
ready
[   32.678222] fmdrv: Failed to get ST write func pointer
[   32.703948] (stc):  chnl_id 8 not supported
[   32.703948] fmdrv: st_unregister failed -93
[   32.724578] fmdrv: Unable to prepare FM CORE
[   33.382476] Requested mode 2

...so I guess it is not going to work. I use configuration with all
drivers built in.

FM radio is not a priority for me, but if you know how to get it to
work, I'll try...

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180422/fc2d10f4/attachment.sig>
