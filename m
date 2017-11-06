From: daniel@ffwll.ch (Daniel Vetter)
Date: Mon, 6 Nov 2017 09:40:43 +0100
Subject: [PATCH v2 00/10] Allwinner H3/H5/A64(DE2) SimpleFB support
In-Reply-To: <20171102154447.b5qo3rvu5djxupay@flea>
References: <20171027150658.18509-1-icenowy@aosc.io>
 <9bca10cc95d04f87a1122bc582402310@aosc.io>
 <20171102154447.b5qo3rvu5djxupay@flea>
Message-ID: <20171106084043.2vv56w2dmrutz4gn@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 02, 2017 at 04:44:47PM +0100, Maxime Ripard wrote:
> On Thu, Nov 02, 2017 at 04:51:29PM +0800, Icenowy Zheng wrote:
> > ? 2017-10-27 23:06?Icenowy Zheng ???
> > > This patchset adds support for the SimpleFB on Allwinner SoCs with
> > > "Display Engine 2.0".
> > > 
> > > PATCH 1 to PATCH 3 are DE2 CCU fixes for H3/H5 SoCs.
> > > 
> > > PATCH 4 adds the pipeline strings for DE2 SimpleFB.
> > > 
> > > PATCH 5 to 7 adds necessary device tree nodes (DE2 CCU and SimpleFB)
> > > for H3/H5 SoCs.
> > > 
> > > PATCH 8 to 10 are for Allwinner A64 SoC to enable SimpleFB.
> > > 
> > > Icenowy Zheng (10):
> > >   dt-bindings: fix the binding of Allwinner DE2 CCU of A83T and H3
> > >   clk: sunxi-ng: add support for Allwinner H3 DE2 CCU
> > >   clk: sunxi-ng: fix the A64/H5 clock description of DE2 CCU
> > >   dt-bindings: simplefb-sunxi: add pipelines for DE2
> > >   ARM: sun8i: h3/h5: add DE2 CCU device node for H3
> > >   arm64: allwinner: h5: add compatible string for DE2 CCU
> > >   ARM: sunxi: h3/h5: add simplefb nodes
> > >   dt-bindings: add binding for A64 DE2 CCU SRAM
> > >   arm64: allwinner: a64: add DE2 CCU for A64 SoC
> > >   arm64: allwinner: a64: add simplefb for A64 SoC
> > 
> > Maxime, could you review and, if possible, apply the H3/5
> > part of this patchset?
> 
> This came a bit late, we're too close from the merge window
> now. Please resend them after -rc1 is out.

Just dropping here that drm-misc is open all the time, making for a much
better process for contributors :-)
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
