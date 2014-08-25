From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 25 Aug 2014 14:29:32 +0800
Subject: [PATCH 0/6] SolidRun Hummingboard/Cubox-i DT updates
In-Reply-To: <20140823091058.GO30401@n2100.arm.linux.org.uk>
References: <20140823091058.GO30401@n2100.arm.linux.org.uk>
Message-ID: <20140825062930.GA6928@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 23, 2014 at 10:10:58AM +0100, Russell King - ARM Linux wrote:
> Here's a set of patches updating the Cubox-i/Hummingboard DT files.
> 
> The first two are fairly important fixes, so should at least go in
> for -rc kernels.
> 
> The SPDIF patch is something which could go in -rc as well as it's a
> cosmetic patch, changing the name displayed in (eg) pulseaudio for the
> SPDIF output from the developer-centric "imx-spdif" to "Integrated SPDIF".

I will sent the first 3 for -rc.  But I second Iain's comment that the
first patch should have a better commit log to explain why it's an
important fix.

> 
> Patch 4 updates the Hummingboard support as SolidRun now have a Dual
> version of this platform, which needs imx6q.dtsi instead of imx6dl.dtsi,
> and also has mSATA support.

Though it's mostly just a DTS split, the diff stat looks too scary to
be a material of -rc.

> 
> Patch 5 adds the mSATA support for the Dual version of the Hummingboard.
> 
> Patch 6 is the first patch which breaks something on the initial version
> of the Hummingboard, aka Carrier1, specifically the IrDA receiver.  In
> hindsight, we should not have used the name "Hummingboard" for the
> Carrier1.  The Carrier1 is obsolete, and people are being encouraged to
> dispose of the C1 hardware.
> 
> Out of these, I think it would be worth getting the first five patches
> in for 3.17 (even though we're in -rc), but patch 6 should certainly
> wait for the next merge window.

Patches 4 ~ 6 are not fixes in any way, so I prefer to queue them for
the next merge window.

Shawn
