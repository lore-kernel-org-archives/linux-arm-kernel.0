From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 19 Feb 2016 08:20:00 +0100
Subject: [PATCH 3/3] ARM64: dts: mt8173: Add thermal/auxadc device nodes
In-Reply-To: <56C5EEE9.4020407@gmail.com>
References: <1448883753-19068-1-git-send-email-s.hauer@pengutronix.de>
 <1448883753-19068-4-git-send-email-s.hauer@pengutronix.de>
 <56C5EEE9.4020407@gmail.com>
Message-ID: <20160219071959.GL3939@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matthias,

On Thu, Feb 18, 2016 at 05:18:49PM +0100, Matthias Brugger wrote:
> Hi Sascha,
> 
> On 30/11/15 12:42, Sascha Hauer wrote:
> >This adds the thermal controller and auxadc nodes to the Mediatek MT8173
> >dtsi file.
> >
> >Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> >Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
> >---
> >  arch/arm64/boot/dts/mediatek/mt8173.dtsi | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >
> >diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> >index 06a1564..e2ddd03 100644
> >--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> >+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> >@@ -277,6 +277,11 @@
> >  				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
> >  		};
> >
> >+		auxadc: auxadc at 11001000 {
> >+			compatible = "mediatek,mt8173-auxadc";
> 
> Can you please write a small Documentation about the binding.
> I suppose it will be mediatek,auxadc and mediatek,mt8173-auxadc.

Just did that.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
