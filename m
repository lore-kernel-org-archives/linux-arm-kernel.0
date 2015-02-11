From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 11 Feb 2015 16:23:01 +0100
Subject: [PATCH RFC v8 11/21] Documentation: dt-bindings: Add bindings
 for Synopsys DW MIPI DSI DRM bridge driver
In-Reply-To: <20150211140931.GA6666@victor>
References: <1420014219-915-1-git-send-email-Ying.Liu@freescale.com>
 <1420014219-915-12-git-send-email-Ying.Liu@freescale.com>
 <1423131004.3207.27.camel@pengutronix.de> <20150206081318.GA15088@victor>
 <20150211072128.GA13301@victor> <1423659648.4680.18.camel@pengutronix.de>
 <20150211140931.GA6666@victor>
Message-ID: <1423668181.4680.24.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, den 11.02.2015, 22:09 +0800 schrieb Liu Ying:
> BTW, regarding the compatible string topic, shall I keep my implementation
> unchanged and don't append the additional "snps,dw-mipi-dsi" as I shared
> my concerns about it before?

Leave the implementation unchanged. Still, I'd like to see
"snps,dw-mipi-dsi" appended to the mipi_dsi compatible property in
Documentation/devicetree/bindings/drm/bridge/dw_mipi_dsi.txt
and in arch/arm/boot/dts/imx6qdl.dtsi. After all, Freescale's i.MX6
specific implementation is register compatible to Synopsys' design,
isn't it?

regards
Philipp
