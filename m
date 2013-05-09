From: tony@atomide.com (Tony Lindgren)
Date: Thu, 9 May 2013 13:30:58 -0700
Subject: [GIT PULL 1/2] omap fixes for v3.10 merge window part2
In-Reply-To: <20130509201504.GA21598@quad.lixom.net>
References: <518bef23.e79f320a.5202.ffffc873SMTPIN_ADDED_BROKEN@mx.google.com>
 <20130509201504.GA21598@quad.lixom.net>
Message-ID: <20130509203057.GJ31554@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Olof Johansson <olof@lixom.net> [130509 13:20]:
> On Thu, May 09, 2013 at 11:46:51AM -0700, Tony Lindgren wrote:
> > The following changes since commit 956e46efb2478ebff7a871138458fa8124fd18dd:
> > 
> >   mm/slab: Fix crash during slab init (2013-05-08 15:02:33 -0700)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.10/fixes-for-merge-window-part2
> > 
> > for you to fetch changes up to b1dd11d60e5357c13d3f3decfb69bd07dde159bd:
> > 
> >   ARM: OMAP2+: Remove bogus IS_ERR_OR_NULL checking from id.c (2013-05-09 09:06:27 -0700)
> 
> Pulled, thanks.
> 
> As Arnd mentioned on an ux500 pull request earlier, we usually don't like
> fixes branches on non-rc bases, but since this is targeting pre-rc1 but
> post-what-we-merged, there's not much else to do.

Yes, sorry I should have mentioned that the commit these were based
on is the one that fixed boot issues for me. So not a random commit
of the day, and some of these had dependencies to the patches already
merged.

Regards,

Tony
