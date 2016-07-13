From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 13 Jul 2016 09:26:38 +0200
Subject: [PATCH] userspace API definitions for auto-focus coil
In-Reply-To: <20160712203201.7ffd8f22@recife.lan>
References: <20160602212746.GT26360@valkosipuli.retiisi.org.uk>
 <20160605190716.GA11321@amd> <575512E5.5030000@gmail.com>
 <20160611220654.GC26360@valkosipuli.retiisi.org.uk>
 <20160612084811.GA27446@amd>
 <20160612112253.GD26360@valkosipuli.retiisi.org.uk>
 <20160613191753.GA17459@amd>
 <20160617213545.GH24980@valkosipuli.retiisi.org.uk>
 <20160618153846.GA15662@amd> <20160712203201.7ffd8f22@recife.lan>
Message-ID: <20160713072638.GB3781@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 2016-07-12 20:32:01, Mauro Carvalho Chehab wrote:
> Em Sat, 18 Jun 2016 17:38:46 +0200
> Pavel Machek <pavel@ucw.cz> escreveu:
> 
> > Hi!
> > 
> > > > Not V4L2_CID_USER_AD5820...?  
> > > 
> > > The rest of the controls have no USER as part of the macro name, so I
> > > wouldn't use it here either.  
> > 
> > Ok.
> > 
> > > > Ok, separate header file for 2 lines seemed like a bit of overkill,
> > > > but why not.  
> > > 
> > > That follows an existing pattern of how controls have been implemented in
> > > other drivers.  
> > 
> > Ok.
> > 
> > > Could you merge this with the driver patch? I've dropped that from my ad5820
> > > branch as it does not compile.  
> > 
> > Yes, merged patch should be in your inbox now.
> 
> The V4L2 core changes should be on a separate patch. Btw, you'll also
> need to patch documentation to reflect such changes. We're right now
> moving from DocBook to ReST markup language. The patches for it are
> right now on a separate topic branch (docs-next), to be merged for
> Kernel 4.8 on the next merge window.

What about: I drop all the functionality but FOCUS_ABSOLUTE, which is
core functionality, anyway, and does not need core changes. When V4L2
core stabilizes, it can be reintroduced.

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
