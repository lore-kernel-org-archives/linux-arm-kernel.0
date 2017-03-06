From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 6 Mar 2017 18:38:16 +0000
Subject: [PATCH 2/3] arm: kprobes: remove kprobe_exceptions_notify
In-Reply-To: <20170306180720.GC7467@naverao1-tp.localdomain>
References: <b0894e503195b13a5ed6319e897e673f376a748d.1486496890.git.naveen.n.rao@linux.vnet.ibm.com>
 <46a640f65b86650d3a7d64a577dd441838de1c20.1486496890.git.naveen.n.rao@linux.vnet.ibm.com>
 <20170306180720.GC7467@naverao1-tp.localdomain>
Message-ID: <20170306183815.GX21222@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 06, 2017 at 11:37:20PM +0530, Naveen N. Rao wrote:
> On 2017/02/08 01:24AM, Naveen N Rao wrote:
> > ... as the weak variant will do.
> > 
> > Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> > ---
> >  arch/arm/probes/kprobes/core.c     | 10 ----------
> >  arch/arm64/kernel/probes/kprobes.c |  6 ------
> >  2 files changed, 16 deletions(-)
> 
> With the generic changes in this series now in -rc1, can you please pick 
> this up?

It would've been nice to have been in the To: or Cc: on this patch,
I suspect everyone on the ARM side ignored this series (I certainly
didn't notice it, and I suspect the ARM64 folk didn't notice it for
exactly the same reason.)

In any case, this patch needs to be split - ARM and ARM64 are
maintained separately (as stated in MAINTAINERS), and patches go via
different trees.  Please resubmit with the patch split between the
architectures and proper recipients in the headers.

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
