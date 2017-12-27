From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 27 Dec 2017 22:39:56 +0100
Subject: v4.15: camera problems on n900
In-Reply-To: <20171227211718.favif66afztygfje@kekkonen.localdomain>
References: <20171227210543.GA19719@amd>
 <20171227211718.favif66afztygfje@kekkonen.localdomain>
Message-ID: <20171227213956.GB9205@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


1;2802;0cOn Wed 2017-12-27 23:17:19, Sakari Ailus wrote:
> On Wed, Dec 27, 2017 at 10:05:43PM +0100, Pavel Machek wrote:
> > Hi!
> > 
> > In v4.14, back camera on N900 works. On v4.15-rc1.. it works for few
> > seconds, but then I get repeated oopses.
> > 
> > On v4.15-rc0.5 (commit ed30b147e1f6e396e70a52dbb6c7d66befedd786),
> > camera does not start.	  
> > 
> > Any ideas what might be wrong there?
> 
> What kind of oopses do you get?

They seemed to be in unrelated processes -> not useful for
debugging. I tried again, but this time it hangs, similar way to
-rc0.5. (That might be good news).

Does it work for you on N9?

Thanks,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171227/e7892f96/attachment.sig>
