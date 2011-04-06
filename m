From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Wed, 6 Apr 2011 17:46:43 +0300
Subject: [PATCH] pxa2xx_spi: Fix race condition in stop_queue()
In-Reply-To: <BANLkTikZrjgjJBpeBoSHGzCshYrHQZ6hQg@mail.gmail.com>
References: <1300055230-29628-1-git-send-email-anarsoul@gmail.com>
	<201104042047.55504.anarsoul@gmail.com>
	<BANLkTikZrjgjJBpeBoSHGzCshYrHQZ6hQg@mail.gmail.com>
Message-ID: <201104061746.44134.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 05 April 2011 06:21:27 Eric Miao wrote:
> On Tue, Apr 5, 2011 at 1:47 AM, Vasily Khoruzhick <anarsoul@gmail.com> 
wrote:
> > On Monday 04 April 2011 20:35:14 Mike Frysinger wrote:
> >> that's fine, i do.  was this patch actually merged ?  or is there a
> >> new version on the way ?
> >> -mike
> > 
> > I suspect it's not merged yet. Btw, should I make a patch which fixes all
> > drivers, or it's prefferable to make one patch per driver?
> 
> Please come up with one patch, Mike can help add a Tested-by then.

Sorry, but I did not get if you want splitted patch or not :) Anyway, 4 on-
line-patches does not look reasonable anyway, so I'm sending not-splitted 
patch in few minutes.
