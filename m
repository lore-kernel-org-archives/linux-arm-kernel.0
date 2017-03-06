From: naveen.n.rao@linux.vnet.ibm.com (Naveen N. Rao)
Date: Tue,  7 Mar 2017 00:34:55 +0530
Subject: [PATCH 2/3] arm: kprobes: remove kprobe_exceptions_notify
In-Reply-To: <20170306183815.GX21222@n2100.armlinux.org.uk>
References: <20170306183815.GX21222@n2100.armlinux.org.uk>
Message-ID: <cover.1488826671.git.naveen.n.rao@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017/03/06 06:38PM, Russell King - ARM Linux wrote:
> On Mon, Mar 06, 2017 at 11:37:20PM +0530, Naveen N. Rao wrote:
> > On 2017/02/08 01:24AM, Naveen N Rao wrote:
> > > ... as the weak variant will do.
> > > 
> > > Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> > > ---
> > >  arch/arm/probes/kprobes/core.c     | 10 ----------
> > >  arch/arm64/kernel/probes/kprobes.c |  6 ------
> > >  2 files changed, 16 deletions(-)
> > 
> > With the generic changes in this series now in -rc1, can you please pick 
> > this up?
> 
> It would've been nice to have been in the To: or Cc: on this patch,
> I suspect everyone on the ARM side ignored this series (I certainly
> didn't notice it, and I suspect the ARM64 folk didn't notice it for
> exactly the same reason.)
> 
> In any case, this patch needs to be split - ARM and ARM64 are
> maintained separately (as stated in MAINTAINERS), and patches go via
> different trees.  Please resubmit with the patch split between the
> architectures and proper recipients in the headers.

Got it. Please find the updated patches in this thread.

Thanks,
Naveen
