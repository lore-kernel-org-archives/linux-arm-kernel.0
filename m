From: horms@verge.net.au (Simon Horman)
Date: Fri, 2 Dec 2016 15:00:32 +0100
Subject: [PATCH 0/4] ARM, arm64: dts: Use usb-phy fallback bindings
In-Reply-To: <CAMuHMdUHBh-=nu3HqqwNq-f5QauAFAAHRS4TUYW10zP4BJMhvg@mail.gmail.com>
References: <1480602354-1446-1-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdUHBh-=nu3HqqwNq-f5QauAFAAHRS4TUYW10zP4BJMhvg@mail.gmail.com>
Message-ID: <20161202140031.GA29916@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 01, 2016 at 03:47:57PM +0100, Geert Uytterhoeven wrote:
> On Thu, Dec 1, 2016 at 3:25 PM, Simon Horman <horms+renesas@verge.net.au> wrote:
> > this short series makes use of fallback bindings for Renesas R-Car PHY
> > drivers in the DT of SoCs which already use those drivers.
> >
> > Simon Horman (4):
> >   ARM: dts: r8a7790: Use renesas,rcar-gen2-usb-phy fallback binding
> >   ARM: dts: r8a7791: Use renesas,rcar-gen2-usb-phy fallback binding
> >   ARM: dts: r8a7794: Use renesas,rcar-gen2-usb-phy fallback binding
> >   arm64: dts: r8a7795: Use renesas,rcar-gen3-usb2-phy fallback binding
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, I have queued these up for v4.11.
