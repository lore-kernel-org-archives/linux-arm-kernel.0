From: horms@verge.net.au (Simon Horman)
Date: Thu, 29 Jan 2015 10:32:28 +0900
Subject: [PATCH] ARM: shmobile: r8a7794: Correct SDHI clock base address,
 labels and output-names
In-Reply-To: <CAMuHMdWzvwmX8uN+Do-1vZiSeqknLdgmv060GCvbZd1=x4YnXA@mail.gmail.com>
References: <1422406422-671-1-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdWzvwmX8uN+Do-1vZiSeqknLdgmv060GCvbZd1=x4YnXA@mail.gmail.com>
Message-ID: <20150129013228.GA15358@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 28, 2015 at 10:14:53AM +0100, Geert Uytterhoeven wrote:
> On Wed, Jan 28, 2015 at 1:53 AM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > * Correct base address of SD3 div6 clk.
> > * Update div6 clock node labels
> >   There appears to have been some inconsistency and confusion here as on
> >   the r8a7790 these clocks are referred to as SD(HI)1 and SD(HI)2 while on
> >   the r8a7791 and r8a7794 they are referred to as SD(HI)2 and SD(HI)3.
> >
> > This has no run-time affect as the clock nodes are not currently used.
> >
> > Fixes: 8e181633e6ca96049 ("ARM: shmobile: r8a7794: Add SDHI clocks to device tree")
> > Reported-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> > Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, I will queue this up.
