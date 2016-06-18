From: pavel@ucw.cz (Pavel Machek)
Date: Sat, 18 Jun 2016 17:38:46 +0200
Subject: [PATCH] userspace API definitions for auto-focus coil
In-Reply-To: <20160617213545.GH24980@valkosipuli.retiisi.org.uk>
References: <20160602074544.GR26360@valkosipuli.retiisi.org.uk>
 <20160602193027.GB7984@amd>
 <20160602212746.GT26360@valkosipuli.retiisi.org.uk>
 <20160605190716.GA11321@amd> <575512E5.5030000@gmail.com>
 <20160611220654.GC26360@valkosipuli.retiisi.org.uk>
 <20160612084811.GA27446@amd>
 <20160612112253.GD26360@valkosipuli.retiisi.org.uk>
 <20160613191753.GA17459@amd>
 <20160617213545.GH24980@valkosipuli.retiisi.org.uk>
Message-ID: <20160618153846.GA15662@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > Not V4L2_CID_USER_AD5820...?
> 
> The rest of the controls have no USER as part of the macro name, so I
> wouldn't use it here either.

Ok.

> > Ok, separate header file for 2 lines seemed like a bit of overkill,
> > but why not.
> 
> That follows an existing pattern of how controls have been implemented in
> other drivers.

Ok.

> Could you merge this with the driver patch? I've dropped that from my ad5820
> branch as it does not compile.

Yes, merged patch should be in your inbox now.

Thanks,
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
