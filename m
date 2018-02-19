From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 19 Feb 2018 21:35:19 +0100
Subject: setterm -blank force no longer works after switch to omapdrm
In-Reply-To: <20180219191623.GA2347@amd>
References: <20180217211927.GC9640@amd>
 <20180219191623.GA2347@amd>
Message-ID: <20180219203519.GA4936@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 2018-02-19 20:16:23, Pavel Machek wrote:
> On Sat 2018-02-17 22:19:27, Pavel Machek wrote:
> > Hi!
> > 
> > I used to have use omap fb driver, and blanking worked as expected. It
> > no longer works with omap drm driver. (Tested on v4.16-rc1, but I
> > believe it is broken in older versions, too.)
> > 
> > Can you test it on your hw? Any ideas what could be wrong?
> > 
> > xset dpms force on/off works as expected.
> 
> next-20180219 seems to work as expected, too.

...because I did not switch to omap drm driver for my next- kernels,
yet. Oops :-).
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180219/a70cb073/attachment-0001.sig>
