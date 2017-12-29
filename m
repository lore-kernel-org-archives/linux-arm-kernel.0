From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 29 Dec 2017 17:30:22 +0100
Subject: v4.15: camera problems on n900
In-Reply-To: <20171229093855.hz44vpssb5mufzop@valkosipuli.retiisi.org.uk>
References: <20171227210543.GA19719@amd>
 <20171227211718.favif66afztygfje@kekkonen.localdomain>
 <20171228202453.GA20142@amd>
 <20171229093855.hz44vpssb5mufzop@valkosipuli.retiisi.org.uk>
Message-ID: <20171229163022.GA31142@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 2017-12-29 11:38:55, Sakari Ailus wrote:
> On Thu, Dec 28, 2017 at 09:24:53PM +0100, Pavel Machek wrote:
> > On Wed 2017-12-27 23:17:19, Sakari Ailus wrote:
> > > On Wed, Dec 27, 2017 at 10:05:43PM +0100, Pavel Machek wrote:
> > > > Hi!
> > > > 
> > > > In v4.14, back camera on N900 works. On v4.15-rc1.. it works for few
> > > > seconds, but then I get repeated oopses.
> > > > 
> > > > On v4.15-rc0.5 (commit ed30b147e1f6e396e70a52dbb6c7d66befedd786),
> > > > camera does not start.	  
> > > > 
> > > > Any ideas what might be wrong there?
> > > 
> > > What kind of oopses do you get?
> > 
> > Hmm. bisect pointed to commit that can't be responsible.... Ideas
> > welcome.
> 
> Hi Pavel,
> 
> I tested N9 and capture appears to be working from the CSI-2 receiver
> (media tree master, i.e. v4.15-rc3 now).
> 
> Which pipeline did you use?

I'm using the "main" sensor (5MPx) and am using capture (not preview)
pipeline.

I tested linux-next in the meantime, and that one seems to
work. (Which is strange, I believe it oopsed before. Perhaps something
random?) With linux-next working, it should not be hardto figure out
what is going on.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171229/8f7efadb/attachment.sig>
