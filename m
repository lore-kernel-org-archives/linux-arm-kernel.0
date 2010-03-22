From: allen.pais@ti.com (Pais, Allen)
Date: Mon, 22 Mar 2010 12:48:33 +0530
Subject: [PATCH] arm: Fix DEBUG_LL for omap zoom2/3
In-Reply-To: <20100320024827.GC11448@atomide.com>
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E94026F126B9C@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 
> > > Hi all,
> > > 
> > > Got a zoom3 finally! This is needed to boot with DEBUG_LL 
> + earlyprintk.
> > 
> > And of course it won't compile because of a missing #.
> > Here's the working version.
> 
> One more time. Looks like what I posted is not enough, we
> also need to make sure the mapping does not overlap with
> other regions. So basically we can't use 0xfb000000 like
> we currently have, let's use 0xf7000000 instead unless
> somebody has better ideas.

 With this patch[DEBUG_LL + earlyprintk],
 I still haven't been able to boot the kernel.
 Is it working on your side.
  
 The commit am using is : a842b5f9ce70e1b738eabb4d719860070180ed1c

- Allen

> 
> Regards,
> 
> Tony
> 
