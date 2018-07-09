From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 9 Jul 2018 10:52:00 +0800
Subject: [linux-sunxi] [PATCH v2 0/9] Allwinner H6 USB support
In-Reply-To: <20180706153805.25842-1-icenowy@aosc.io>
References: <20180706153805.25842-1-icenowy@aosc.io>
Message-ID: <CAGb2v6613vcxaA0J5L_bm=ZCU_bkCkeK-icrq_y7Mmd1+MMrHQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 6, 2018 at 11:37 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> This patchset introduces support for the USB ports (both USB2 and USB3)
> on the Allwinner H6 SoC.
>
> This revision adds the USB2 support, and places it before the USB3
> support. So only the USB3 part will have changelog in this revision.
>
> The first 5 PATCHes are the USB2 part, and the latter 4 PATCHes are the
> USB3 part.
>
> PATCH 1, 2, 6, 7 should go through the PHY tree, and the remaining
> patches should go through the armsoc tree via sunxi tree.
>
> Icenowy Zheng (9):
>   phy: sun4i-usb: add support for missing USB PHY index
>   phy: sun4i-usb: add support for H6 USB2 PHY
>   arm64: allwinner: dts: h6: add USB2-related device nodes
>   arm64: allwinner: dts: h6: add USB Vbus regulator
>   arm64: allwinner: dts: h6: enable USB2 on Pine H64
>   dt-bindings: phy: add binding for Allwinner USB3 PHY
>   phy: allwinner: add phy driver for USB3 PHY on Allwinner H6 SoC
>   arm64: allwinner: dts: h6: add USB3 device nodes
>   arm64: allwinner: dts: h6: enable USB3 port on Pine H64

Apart from my comments in a few patches, this series is

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
