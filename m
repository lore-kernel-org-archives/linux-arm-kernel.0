From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 28 Jan 2018 10:16:12 +0100
Subject: [PATCH] Nokia N9: add support for up/down keys in the dts
In-Reply-To: <20180119154325.GF4042@atomide.com>
References: <20180102125948.GA20051@amd>
 <20180102194236.ahrhkvnefre2l6gf@earth.universe>
 <20180118220348.GD17196@amd> <20180119154325.GF4042@atomide.com>
Message-ID: <20180128091612.GB23818@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > > > This adds support for volume up/down keys in the dts.
> > > > 
> > > > Signed-off-by: Pavel Machek <pavel@ucw.cz>
> > > 
> > > Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> > 
> > Tony, ping? Can I get you to apply this one?
> 
> OK applying that for v4.16 so we have some kind of control of the
> device without having to rely on the touch screen :)

Thanks :-).

> > [PATCHv2] nokia N9: Add support for magnetometer
> > 
> > should be good to go, too...
> 
> I have that tagged for next after -rc1 thanks.

Actually, if you could get that one to v4.16, too. There's still lot
of work to be done to get N9 into usable state, and delaying here does
not do any good.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180128/8c14a83b/attachment.sig>
