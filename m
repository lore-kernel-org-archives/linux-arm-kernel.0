From: zhiyong.tao@mediatek.com (Zhiyong Tao)
Date: Wed, 2 Aug 2017 10:58:52 +0800
Subject: [PATCH 0/3] PINCTRL: Mediatek pinctrl driver for mt2712
In-Reply-To: <1501577069.32089.0.camel@mtksdaap41>
References: <1501489333-23145-1-git-send-email-zhiyong.tao@mediatek.com>
 <1501577069.32089.0.camel@mtksdaap41>
Message-ID: <1501642732.844.14.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-08-01 at 16:44 +0800, Yingjoe Chen wrote:
> On Mon, 2017-07-31 at 16:22 +0800, Zhiyong Tao wrote:
> > This series includes three patches:
> > 1.Add mt2712 compatible node in binding document.
> > 2.Add mt2712 pinctrl device node.
> > 3.Add mt2712 pinctrl driver.
> > 
> > Zhiyong Tao (3):
> >   dt-bindings: pinctrl: mt2712: add binding document
> >   arm64: dts: mt2712: add pintcrl device node.
> >   pinctrl: add mt2712 pinctrl driver
> > 
> >  .../devicetree/bindings/pinctrl/pinctrl-mt65xx.txt |    1 +
> >  arch/arm64/boot/dts/mediatek/mt2712-pinfunc.h      | 1014 +++++++++++
> >  arch/arm64/boot/dts/mediatek/mt2712e.dtsi          |   18 +
> 
> mt2712e.dtsi doesn't exists in v4.13-rc1.
> What's the base for this series? 
> 
>
> 
> 
==> This patch is based on 
http://lists.infradead.org/pipermail/linux-mediatek/2017-July/009618.html
I forgot to add the comment, I will add it in the next version.
Thanks.
