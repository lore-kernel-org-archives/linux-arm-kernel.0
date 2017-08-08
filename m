From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 8 Aug 2017 12:34:44 +0200
Subject: linux-next 2017-08-08 failure on Nokia N900
In-Reply-To: <20170808101756.GA12922@amd>
References: <20170808101756.GA12922@amd>
Message-ID: <20170808103444.GA18247@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> I tried today's linux-next. It boots on n900 (up to X), but then my
> screen locks and I can't get back. Touchscreen worked, so my guess is
> keyboard does not...? Ssh connection over usb still works.

Confirmed, its the keyboard.

Additionally, battery monitoring fails, because neither

/sys/class/power_supply/{n900-,rx51-}battery/voltage_now

exists.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170808/fdec8f57/attachment.sig>
