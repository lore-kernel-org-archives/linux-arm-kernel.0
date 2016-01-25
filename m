From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 25 Jan 2016 17:35:41 +0530
Subject: [PATCH 03/15] dmaengine: dw: rename masters to reflect actual
 topology
In-Reply-To: <yw1xk2myli0u.fsf@unicorn.mansr.com>
References: <1453663322-14474-1-git-send-email-mans@mansr.com>
 <1453663322-14474-4-git-send-email-mans@mansr.com>
 <20160124223629.GI6588@sirena.org.uk>
 <yw1xk2myli0u.fsf@unicorn.mansr.com>
Message-ID: <20160125120541.GH11130@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 24, 2016 at 10:38:57PM +0000, M?ns Rullg?rd wrote:
> Mark Brown <broonie@kernel.org> writes:
> 
> > On Sun, Jan 24, 2016 at 07:21:50PM +0000, Mans Rullgard wrote:
> >> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >> 
> >> The source and destination masters are reflecting buses or their layers to
> >> where the different devices can be connected. The patch changes the master
> >> names to reflect which one is related to which independently on the transfer
> >> direction.
> >
> > This is patch 3 of a series but I don't have anything else in the
> > series.  What is going on with the rest of the series - what are the
> > dependencies and so on?
> 
> I give up.  Seriously, this is impossible.  If I don't include everybody
> in the slightest way related to any patch in the series, I get
> complaints that patches are missing.  If I do, the lists reject it all
> due to too many recipients.  What the hell am I supposed to do?

Right practice is to CC everyone in cover-letter and mention which subsystem
this is intended to be merged thru and CC relevant folks on the patches.

That gives everyone context and right attention and lesser noise on patches

-- 
~Vinod
