From: horms@verge.net.au (Simon Horman)
Date: Thu, 22 Aug 2013 15:32:01 +0900
Subject: [PATCH 00/02] ARM: shmobile: Rename to
 r8a73a4/r8a7790_init_early()
In-Reply-To: <20130821090018.GJ20014@verge.net.au>
References: <20130807222638.22283.78607.sendpatchset@w520>
 <20130821090018.GJ20014@verge.net.au>
Message-ID: <20130822063159.GR11086@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 21, 2013 at 06:00:18PM +0900, Simon Horman wrote:
> On Thu, Aug 08, 2013 at 07:26:38AM +0900, Magnus Damm wrote:
> > ARM: shmobile: Rename to r8a73a4/r8a7790_init_early()
> > 
> > [PATCH 01/02] ARM: shmobile: Rename to r8a73a4_init_early()
> > [PATCH 02/02] ARM: shmobile: Rename to r8a7790_init_early()
> > 
> > This series renames r8a73a4/r8a7790_init_delay() to 
> > r8a73a4/r8a7790_init_early(). The reason for this is
> > that future SMP code will hook into these functions
> > which will make them handle more than just delay setup.
> > 
> > Signed-off-by: Magnus Damm <damm@opensource.se>
> > ---
> > 
> >  Written against renesas.git renesas-devel-20130806v4 and
> >  [PATCH 00/05] ARM: shmobile: Yet another SMP series
> > 
> >  arch/arm/mach-shmobile/board-ape6evm-reference.c |    2 +-
> >  arch/arm/mach-shmobile/board-ape6evm.c           |    2 +-
> >  arch/arm/mach-shmobile/board-lager-reference.c   |    2 +-
> >  arch/arm/mach-shmobile/board-lager.c             |    2 +-
> >  arch/arm/mach-shmobile/include/mach/r8a73a4.h    |    2 +-
> >  arch/arm/mach-shmobile/include/mach/r8a7790.h    |    2 +-
> >  arch/arm/mach-shmobile/setup-r8a73a4.c           |    4 ++--
> >  arch/arm/mach-shmobile/setup-r8a7790.c           |    4 ++--
> >  8 files changed, 10 insertions(+), 10 deletions(-)
> 
> Thanks Magnus, I have plan to queue this up in the cleanup4 branch
> which will most likely happen tomorrow.

It has now happened.
