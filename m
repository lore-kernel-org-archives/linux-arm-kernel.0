From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 26 Oct 2017 18:28:07 +0200
Subject: 4.13 (and probably all recent) kernels refuse to boot on one
 Nokia N950, work or another
In-Reply-To: <20171026120130.dicanunwcdmjntnb@earth>
References: <20171025203459.GA22035@amd> <20171025212806.GA21504@atomide.com>
 <20171026091325.GA26929@amd>
 <20171026093115.4bc6ctxjx72ng7ld@earth>
 <20171026095734.GA10141@amd>
 <20171026120130.dicanunwcdmjntnb@earth>
Message-ID: <20171026162807.GA20639@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > > Glad you got it working :) For backlight you can add this
> > > in drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c:
> > > 
> > > add the following code at the end of dsicm_probe:
> > 
> > You did not actually include code to paste into panel-dsi-cm, can you
> > try a again?
> 
> I added it directly below and you quoted it. I guess you mistook it
> for a signature or something :)

Ahha. Two semicolons confused me, and I thought you were talking about
two different files. My fault. Let me try...

And.. If I catch the bus, I should be at cca 20:15 at the Hilton. We
can meet at the seats where we were hacking...?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171026/194ab3c9/attachment.sig>
