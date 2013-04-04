From: horms@verge.net.au (Simon Horman)
Date: Thu, 4 Apr 2013 12:33:39 +0900
Subject: [GIT PULL v2] Renesas ARM SoC board updates for v3.10 #3
In-Reply-To: <20130403063059.GB29601@quad.lixom.net>
References: <1364954906-16014-1-git-send-email-horms+renesas@verge.net.au>
 <20130403063059.GB29601@quad.lixom.net>
Message-ID: <20130404033338.GB28297@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 02, 2013 at 11:30:59PM -0700, Olof Johansson wrote:
> Hi,
> 
> On Wed, Apr 03, 2013 at 11:08:15AM +0900, Simon Horman wrote:
> > Hi Olof, Hi Arnd,
> > 
> > The following changes since commit eb0ae7280939fda741ad6ae9b108725517652f56:
> > 
> >   Merge tag 'renesas-pinmux2-for-v3.10' into boards-base (2013-04-03 10:49:18 +0900)
> > 
> > are available in the git repository at:
> > 
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-boards3-for-v3.10
> 
> Pulled in in a next/boards2 since it depends on next/soc2.
> 
> >  arch/arm/configs/bockw_defconfig             |   66 +++++++++++++++
> 
> shmobile is now up to 11 defconfigs in arch/arm/configs. It'd be nice if
> you could move towards what OMAP and many other platforms have started
> doing for a while now, with one superset defconfig for the platform
> (well, one for v4/v5 harware and one for v6+).

The not so good news is that there is one more in the pipeline for
the lager board.

The more positive news is that this morning I sent out a series
to try and kick of consolidation. I have CCed you on that series.
