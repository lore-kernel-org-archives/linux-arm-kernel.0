From: horms@verge.net.au (Simon Horman)
Date: Thu, 22 May 2014 07:55:34 +0900
Subject: [GIT PULL] Renesas ARM Based SoC r7s72100-ccf Updates for v3.16
In-Reply-To: <20140521213416.GC24972@quad.lixom.net>
References: <cover.1400201383.git.horms+renesas@verge.net.au>
 <20140521213416.GC24972@quad.lixom.net>
Message-ID: <20140521225534.GB19986@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 21, 2014 at 02:34:16PM -0700, Olof Johansson wrote:
> On Fri, May 16, 2014 at 09:58:33AM +0900, Simon Horman wrote:
> > Hi Olof, Hi Kevin, Hi Arnd,
> > 
> > Please consider these Renesas ARM based SoC r7s72100-ccf updates for v3.16.
> > 
> > This pull request is based on Renesas SoC Clock Cleanups for v3.16,
> > such requests, tagged as renesas-clock-cleanup2-for-v3.16,
> > which I have already sent a pull-request for.
> > 
> > 
> > This series includes dependencies that do not fit easily into the usual
> > inter-branch dependencies and as such I have grouped them together in a
> > single branch.
> > 
> > 
> > The following changes since commit c17fcfbcc0f6b4f3cae761149e1a6108dd6750e7:
> > 
> >   ARM: shmobile: r7s72100: Switch to new style MTU2 device (2014-05-11 19:35:28 +0900)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-r7s72100-ccf-for-v3.16
> 
> Seems like lots of stuff is ending up in next/boards now. That's OK. This
> branch too.

Thanks. At a high level I think we are experiencing this due to various
efforts to convert our SoCs and boards over to multiplatform. I suspect
this will continue on a per-SoC/board basis until all the conversions and
related cleanups are done.
