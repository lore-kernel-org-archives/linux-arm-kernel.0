From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 3 Jun 2018 23:01:15 +0200
Subject: Common config for N900 and D4
In-Reply-To: <20180603165336.GA26995@amd>
References: <20180603104839.GA21197@amd>
 <20180603165336.GA26995@amd>
Message-ID: <20180603210115.GA7438@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > Aaro, I know I have asked before, but if you have common config for
> > N900 and Droid4, please send me a copy. Yes, it should be somewhere in
> > my inbox already, but I can't find it and version for v4.17 would be
> > more useful.
> > 
> > While trying to came up with common config, I hit:
> > 
> > [    0.000000] L2C-310 erratum 727915 enabled
> > [    0.000000] L2C-310 enabling early BRESP for Cortex-A9
> > [    0.000000] L2C-310 full line of zeros enabled for Cortex-A9
> 
> I tried disabling outer cache to get rid of this. That got me further
> in boot, but not to working system:

I now have config that works.

My kernels were probably grossly misconfigured (OMAP4 not enabled on
droid4)... still I'd expect some kind of panic explaining board is not
compatible with kernel, not a random oops...

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180603/1e47dae2/attachment-0001.sig>
