From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 25 May 2015 18:19:43 +0200
Subject: [PATCH] clockevents: don't suspend/resume if unused
In-Reply-To: <20150116165914.GS3843@piout.net>
References: <1421399151-26800-1-git-send-email-alexandre.belloni@free-electrons.com>
 <20150116092014.GA27945@gradator.net>
 <20150116165914.GS3843@piout.net>
Message-ID: <20150525161943.GC3199@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas, Daniel,

Any opinion on that?
Maybe this patch could go in as is?


On 16/01/2015 at 17:59:14 +0100, Alexandre Belloni wrote :
> Hi,
> 
> On 16/01/2015 at 10:20:14 +0100, Sylvain Rochet wrote :
> > > +		if (dev->suspend && dev->mode != CLOCK_EVT_MODE_UNUSED)
> > 
> > I wonder if we should use > CLOCK_EVT_MODE_SHUTDOWN
> > (or CLOCK_EVT_MODE_UNUSED || CLOCK_EVT_MODE_SHUTDOWN) instead of 
> > !CLOCK_EVT_MODE_UNUSED.
> > 
> 
> I'll let Thomas or Daniel decide :) But I'm open to that.
> 
> >-- 
> Alexandre Belloni, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
