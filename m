From: Ying.Liu@freescale.com (Liu Ying)
Date: Thu, 12 Feb 2015 10:14:56 +0800
Subject: [PATCH RFC v8 11/21] Documentation: dt-bindings: Add bindings
 for Synopsys DW MIPI DSI DRM bridge driver
In-Reply-To: <1423668181.4680.24.camel@pengutronix.de>
References: <1420014219-915-1-git-send-email-Ying.Liu@freescale.com>
 <1420014219-915-12-git-send-email-Ying.Liu@freescale.com>
 <1423131004.3207.27.camel@pengutronix.de> <20150206081318.GA15088@victor>
 <20150211072128.GA13301@victor> <1423659648.4680.18.camel@pengutronix.de>
 <20150211140931.GA6666@victor> <1423668181.4680.24.camel@pengutronix.de>
Message-ID: <20150212021454.GA23140@victor>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 11, 2015 at 04:23:01PM +0100, Philipp Zabel wrote:
> Am Mittwoch, den 11.02.2015, 22:09 +0800 schrieb Liu Ying:
> > BTW, regarding the compatible string topic, shall I keep my implementation
> > unchanged and don't append the additional "snps,dw-mipi-dsi" as I shared
> > my concerns about it before?
> 
> Leave the implementation unchanged. Still, I'd like to see
> "snps,dw-mipi-dsi" appended to the mipi_dsi compatible property in
> Documentation/devicetree/bindings/drm/bridge/dw_mipi_dsi.txt
> and in arch/arm/boot/dts/imx6qdl.dtsi. After all, Freescale's i.MX6
> specific implementation is register compatible to Synopsys' design,
> isn't it?

All right.  Will do this in the next version.

Regards,
Liu Ying

> 
> regards
> Philipp
> 
