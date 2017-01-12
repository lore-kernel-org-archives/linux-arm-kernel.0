From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 12 Jan 2017 18:17:13 +0100
Subject: [PATCH 1/5] arm: sunxi: add support for V3s SoC
In-Reply-To: <2706391484163632@web1g.yandex.ru>
References: <20170103151629.19447-1-icenowy@aosc.xyz>
 <20170103151629.19447-2-icenowy@aosc.xyz>
 <20170110180926.ilqtygttpfgbetvu@lukather>
 <2706391484163632@web1g.yandex.ru>
Message-ID: <20170112171713.vzlhoak3ykr3aomp@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

1;4601;0c
On Thu, Jan 12, 2017 at 03:40:32AM +0800, Icenowy Zheng wrote:
> 
> 
> 11.01.2017, 02:09, "Maxime Ripard" <maxime.ripard@free-electrons.com>:
> > On Tue, Jan 03, 2017 at 11:16:25PM +0800, Icenowy Zheng wrote:
> >> ?Allwinner V3s is a low-end single-core Cortex-A7 SoC, with 64MB
> >> ?integrated DRAM, and several peripherals.
> >>
> >> ?Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> >> ?---
> >> ??Documentation/arm/sunxi/README | 4 ++++
> >> ??arch/arm/mach-sunxi/sunxi.c | 1 +
> >> ??2 files changed, 5 insertions(+)
> >>
> >> ?diff --git a/Documentation/arm/sunxi/README b/Documentation/arm/sunxi/README
> >> ?index cd0243302bc1..91ec8f2055be 100644
> >> ?--- a/Documentation/arm/sunxi/README
> >> ?+++ b/Documentation/arm/sunxi/README
> >> ?@@ -67,6 +67,10 @@ SunXi family
> >> ??????????+ Datasheet
> >> ????????????http://dl.linux-sunxi.org/H3/Allwinner_H3_Datasheet_V1.0.pdf
> >>
> >> ?+ - Allwinner V3s (sun8i)
> >> ?+ + Datasheet
> >> ?+ https://www.goprawn.com/forum/allwinner-cams/783-allwinner-v3s-soc-datasheet
> >> ?+
> >
> > Please don't put random links in there, but at least something that we
> > know will be there in a couple of weeks/monthes/years
> 
> Is http://linux-sunxi.org/File:Allwinner_V3s_Datasheet_V1.0.pdf acceptable?

It's much better, yes.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170112/acac9672/attachment.sig>
