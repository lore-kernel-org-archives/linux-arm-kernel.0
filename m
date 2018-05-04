From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Fri, 04 May 2018 10:54:18 +0200
Subject: [PATCH v2 09/10] ARM: dts: sun7i-a20: Add Video Engine and
 reserved memory nodes
In-Reply-To: <e8cd340605ab4db8ebf2888a4fce645e8bc481d0.camel@bootlin.com>
References: <20180419154124.17512-1-paul.kocialkowski@bootlin.com>
 <20180419154536.17846-5-paul.kocialkowski@bootlin.com>
 <20180420073908.nkcbsdxibnzkqski@flea>
 <82057e2f734137a3902d9313c228b01ceb345ee7.camel@bootlin.com>
 <20180504084008.h6p4brari3xrbv6l@flea>
 <e8cd340605ab4db8ebf2888a4fce645e8bc481d0.camel@bootlin.com>
Message-ID: <5f7961d548b4d27eab8e0bd6bcfc35ea70e2d79b.camel@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2018-05-04 at 10:47 +0200, Paul Kocialkowski wrote:
> > > > Don't you also need to map the SRAM on the A20?
> > > 
> > > That's a good point, there is currently no syscon handle for A20
> > > (and
> > > also A13). Maybe SRAM is muxed to the VE by default so it "just
> > > works"? 

I just checked on the manual and it appears that SRAM Area C1 is muxed
to the VE at reset, so we can probably keep things as-is until the SRAM
driver is ready to handle explicitly muxing that area to the VE.

-- 
Paul Kocialkowski, Bootlin (formerly Free Electrons)
Embedded Linux and kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180504/ea0e5029/attachment.sig>
