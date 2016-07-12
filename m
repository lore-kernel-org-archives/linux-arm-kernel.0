From: mchehab@osg.samsung.com (Mauro Carvalho Chehab)
Date: Tue, 12 Jul 2016 20:32:01 -0300
Subject: [PATCH] userspace API definitions for auto-focus coil
In-Reply-To: <20160618153846.GA15662@amd>
References: <20160602074544.GR26360@valkosipuli.retiisi.org.uk>
 <20160602193027.GB7984@amd>
 <20160602212746.GT26360@valkosipuli.retiisi.org.uk>
 <20160605190716.GA11321@amd> <575512E5.5030000@gmail.com>
 <20160611220654.GC26360@valkosipuli.retiisi.org.uk>
 <20160612084811.GA27446@amd>
 <20160612112253.GD26360@valkosipuli.retiisi.org.uk>
 <20160613191753.GA17459@amd>
 <20160617213545.GH24980@valkosipuli.retiisi.org.uk>
 <20160618153846.GA15662@amd>
Message-ID: <20160712203201.7ffd8f22@recife.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Em Sat, 18 Jun 2016 17:38:46 +0200
Pavel Machek <pavel@ucw.cz> escreveu:

> Hi!
> 
> > > Not V4L2_CID_USER_AD5820...?  
> > 
> > The rest of the controls have no USER as part of the macro name, so I
> > wouldn't use it here either.  
> 
> Ok.
> 
> > > Ok, separate header file for 2 lines seemed like a bit of overkill,
> > > but why not.  
> > 
> > That follows an existing pattern of how controls have been implemented in
> > other drivers.  
> 
> Ok.
> 
> > Could you merge this with the driver patch? I've dropped that from my ad5820
> > branch as it does not compile.  
> 
> Yes, merged patch should be in your inbox now.

The V4L2 core changes should be on a separate patch. Btw, you'll also
need to patch documentation to reflect such changes. We're right now
moving from DocBook to ReST markup language. The patches for it are
right now on a separate topic branch (docs-next), to be merged for
Kernel 4.8 on the next merge window.

You should either base the patch on such branch or wait for it to be
merged back mainstream to write such documentation additions.


> 
> Thanks,
> 									Pavel
> 


-- 
Thanks,
Mauro
