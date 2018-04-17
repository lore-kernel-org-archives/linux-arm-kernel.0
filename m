From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 17 Apr 2018 09:38:11 +0200
Subject: atmel_mxt_ts on droid4: powersave seems to break the driver
Message-ID: <20180417073811.GA9450@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI!

v4.17-rc1 on motorola droid 4.

If I disable/reenable touschreen with xinput, it fails, with this in
the logs:

[ 1633.749450] cpcap-usb-phy cpcap-usb-phy.0: connected to USB host
[ 1655.938751] atmel_mxt_ts 1-004a: __mxt_read_reg: i2c transfer
failed (-121)
[ 1655.945800] atmel_mxt_ts 1-004a: Failed to read T44 and T5 (-121)
[ 1663.829498] cpcap-usb-phy cpcap-usb-phy.0: connected to USB host

Unfortunately, xscreensaver seems to break it in a similar way.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180417/e7ac8cef/attachment.sig>
