From: horms@verge.net.au (Simon Horman)
Date: Thu, 31 Jul 2014 08:39:29 +0900
Subject: [GIT PULL v2] Renesas ARM Based SoC Boards Cleanups for v3.17
In-Reply-To: <20140730194521.GC18384@quad.lixom.net>
References: <cover.1406166426.git.horms+renesas@verge.net.au>
 <20140730194521.GC18384@quad.lixom.net>
Message-ID: <20140730233929.GA24845@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 30, 2014 at 12:45:21PM -0700, Olof Johansson wrote:
> On Thu, Jul 24, 2014 at 10:57:54AM +0900, Simon Horman wrote:
> > Hi Olof, Hi Kevin, Hi Arnd,
> > 
> > Please consider these Renesas ARM based SoC boards cleanups for v3.17.
> > 
> > 
> > This pull request is based on
> > "Renesas ARM Based SoC DT Timers Updates for v3.17",
> > tagged as renesas-dt-timers-for-v3.17,
> > which I have sent a pull request for.
> > 
> > In this pull-request cleanups are added on top of new development
> > due to the order in which the code was developed. In general
> > we prefer the reverse ordering.
> > 
> > 
> > v2 of this pull request is a rebase of v1 removing
> > a merge of defconfig changes at the base of the pull-request.
> > The motivation for that was to avoid attempts to use
> > genmai_defconfig after the board code it relies on has been removed.
> > Olof indicated he would prefer not to add that dependency.
> > 
> > 
> > The following changes since commit 9394af4314554d15762585a3464cefaa2e6d0420:
> > 
> >   ARM: shmobile: genmai-reference: Enable MTU2 in device tree (2014-07-15 21:26:42 +0900)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-cleanup-boards-for-v3.17
> > 
> > for you to fetch changes up to d2904bb7cd21844ff5e720083b59a344487fcc9b:
> > 
> >   ARM: shmobile: r7s72100: Remove legacy board support (2014-07-24 10:32:53 +0900)
> 
> Given timing and dependencies here, please resend this for 3.18 instead as
> a base cleanup branch. It doesn't do any harm to leave this in there until
> then.

Sure, will do.
