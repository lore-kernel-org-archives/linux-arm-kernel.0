From: horms@verge.net.au (Simon Horman)
Date: Fri, 16 Mar 2018 09:43:17 +0100
Subject: [PATCH] arm64: dts: renesas: r8a7795: Add missing SYS-DMAC2 dmas
In-Reply-To: <CAMuHMdU3DPfq6TJdzbRskiQKGJZM-8MBPUn9cF+SAtyxGCNvrA@mail.gmail.com>
References: <1520518205-23351-1-git-send-email-geert+renesas@glider.be>
 <20180313184330.67oh6gyjwxv44q2i@verge.net.au>
 <CAMuHMdU3DPfq6TJdzbRskiQKGJZM-8MBPUn9cF+SAtyxGCNvrA@mail.gmail.com>
Message-ID: <20180316084315.dcvd6qw2otooqhh4@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 13, 2018 at 08:23:40PM +0100, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Tue, Mar 13, 2018 at 7:43 PM, Simon Horman <horms@verge.net.au> wrote:
> > On Thu, Mar 08, 2018 at 03:10:05PM +0100, Geert Uytterhoeven wrote:
> >> On R-Car H3, on-chip peripheral modules that can make use of DMA are
> >> wired to either SYS-DMAC0 only, or to both SYS-DMAC1 and SYS-DMAC2.
> >>
> >> Add the missing DMA properties pointing to SYS-DMAC2 for HSCIF[0-2],
> >> SCIF[015], and I2C[0-2].  These were initially left out because early
> >> firmware versions prohibited using SYS-DMAC2.  This restriction has been
> >> lifted in IPL and Secure Monitor Rev1.0.6 (released on Feb 25, 2016).
> >>
> >> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > Thanks, applied.
> 
> This one, or v2?

v2
