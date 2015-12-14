From: horms@verge.net.au (Simon Horman)
Date: Mon, 14 Dec 2015 15:29:14 +0900
Subject: [PATCH 6/6] staging: board: armadillo800eva: Use "arm,pl390"
In-Reply-To: <20151214051647.GA3140@kroah.com>
References: <1448023017-21816-1-git-send-email-geert+renesas@glider.be>
 <1448023017-21816-7-git-send-email-geert+renesas@glider.be>
 <20151211162830.GA9306@kroah.com>
 <20151214050526.GC18143@verge.net.au>
 <20151214051647.GA3140@kroah.com>
Message-ID: <20151214062914.GI18143@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 13, 2015 at 09:16:47PM -0800, Greg Kroah-Hartman wrote:
> On Mon, Dec 14, 2015 at 02:05:26PM +0900, Simon Horman wrote:
> > On Fri, Dec 11, 2015 at 11:28:30AM -0500, Greg Kroah-Hartman wrote:
> > > On Fri, Nov 20, 2015 at 01:36:57PM +0100, Geert Uytterhoeven wrote:
> > > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > > ---
> > > > Must be applied together with "ARM: shmobile: r8a7740 dtsi: Use
> > > > "arm,pl390" for GIC"!
> > > > 
> > > > Greg: Can you please provide your ack? Thanks!
> > > 
> > > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > 
> > Thanks Greg,
> > 
> > I have taken the liberty of assuming that ack also applies to
> > patch 5/6 of this series, the other staging/board patch in
> > this series.
> 
> Oops, yes, good call, thanks for doing this.

No problem.

For the record I have queued up these patches for v4.6 as I
believe that the ARM SoC maintainers prefer not to have
driver changes depending on DT changes and the first four patches
of this series are DT changes.
