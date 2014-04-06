From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 6 Apr 2014 19:06:38 +0800
Subject: [PATCH] ARM: i.MX6: update KSZ9031 phy fixup
In-Reply-To: <1396533947.25686.22.camel@EMBLYSD005.adetelgroup.com>
References: <1395421687-12934-1-git-send-email-hchaumette@adeneo-embedded.com>
 <20140402220125.4e203cd2@crub>
 <1396533947.25686.22.camel@EMBLYSD005.adetelgroup.com>
Message-ID: <20140406110635.GA24260@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 03, 2014 at 04:05:47PM +0200, Hubert Chaumette wrote:
> Le mercredi 02 avril 2014 ? 22:01 +0200, Anatolij Gustschin a ?crit :
> > It would be better to configure the pad skews in the board specific
> > way in the device tree. There is a binding for ksz9021 PHY in
> > Documentation/devicetree/bindings/net/micrel-ksz9021.txt.
> 
> I wonder why it it's not used in arch/arm/boot/dts/imx6q-sabrelite.dts
> instead of ksz9021rn_phy_fixup().

Oh, if you look at arch/arm/boot/dts/imx6qdl-sabrelite.dtsi on mainline
tree today, you will find it.

Shawn
