From: horms@verge.net.au (Simon Horman)
Date: Mon, 4 Jun 2018 11:59:46 +0200
Subject: [PATCH 0/3] ARM: shmobile: apmu: Cleanups after legacy SMP
 fallback removal
In-Reply-To: <20180531143947.j56rcjmscflmvf6a@verge.net.au>
References: <1527693328-10559-1-git-send-email-geert+renesas@glider.be>
 <20180531143947.j56rcjmscflmvf6a@verge.net.au>
Message-ID: <20180604095945.qglbwc5rp67g4jpv@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 31, 2018 at 10:39:48AM -0400, Simon Horman wrote:
> On Wed, May 30, 2018 at 05:15:25PM +0200, Geert Uytterhoeven wrote:
> > 	Hi Simon, Magnus,
> > 
> > Now the legacy SMP fallbacks for R-Car H2 and M2-W have been removed, a
> > few more code cleanups can be applied.
> > 
> > The third patch is a bit larger than I had hoped, due to the need to
> > reshuffle a few functions in the absence of forward declarations.
> > 
> > Tested on Lager (R-Car H2) and Koelsch (R-Car M2-W).
> > 
> > Thanks!
> > 
> > Geert Uytterhoeven (3):
> >   ARM: shmobile: apmu: Move cpu_leave_lowpower() to SUSPEND section
> >   ARM: shmobile: apmu: Remove obsolete shmobile_smp_apmu_prepare_cpus()
> >   ARM: shmobile: apmu: Remove platsmp-apmu.h
> 
> This looks fine but I will wait to see if there are other reviews before
> applying.
> 
> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

Thanks, applied.
