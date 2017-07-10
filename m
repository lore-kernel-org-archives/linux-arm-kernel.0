From: horms@verge.net.au (Simon Horman)
Date: Mon, 10 Jul 2017 11:26:55 +0200
Subject: [PATCH 0/7] ARM: dts: renesas: Add Inter Connect RAM
In-Reply-To: <CAMuHMdU7KC4X8+kOFUBiBw2ZHs=aukf+_1iR+Gjw2M+RgJ6mBQ@mail.gmail.com>
References: <1499181798-28859-1-git-send-email-geert+renesas@glider.be>
 <20170710084010.GJ13680@verge.net.au>
 <CAMuHMdU7KC4X8+kOFUBiBw2ZHs=aukf+_1iR+Gjw2M+RgJ6mBQ@mail.gmail.com>
Message-ID: <20170710092654.GP13680@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 10, 2017 at 10:45:23AM +0200, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Mon, Jul 10, 2017 at 10:40 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Tue, Jul 04, 2017 at 05:23:11PM +0200, Geert Uytterhoeven wrote:
> >> R-Car Gen2 and RZ/G1 SoCs contain two or three blocks of SRAM, which can be
> >> used for several purposes.  One such purpose is holding a jump stub for CPU
> >> core bringup.
> >>
> >> This patch series adds the SRAM blocks to the various DTS files, following
> >> the generic DT bindings for "mmio-sram" in
> >> Documentation/devicetree/bindings/sram/sram.txt.  Reserving SRAM for jump
> >> stub for CPU core bringup will be handled in a follow-up series.
> >>
> >> Thanks!
> >
> > Geert, these seem nice and clean to me.
> > Are they ready to be applied?
> 
> I think they are.

Thanks, all patches applied for v4.14.
