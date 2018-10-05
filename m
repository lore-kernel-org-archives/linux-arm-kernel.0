From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 5 Oct 2018 18:44:05 +0800
Subject: [linux-sunxi] [PATCH v4 00/10] Allwinner H6 USB support
In-Reply-To: <20181004122855.22981-1-icenowy@aosc.io>
References: <20181004122855.22981-1-icenowy@aosc.io>
Message-ID: <CAGb2v65qEsJ6Pn+_McSZ8Srsu3JKrfyWhKwUuQOwwOCOpBwOBg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 4, 2018 at 8:29 PM Icenowy Zheng <icenowy@aosc.io> wrote:
>
> This patchset introduces support for the USB ports (both USB2 and USB3)
> on the Allwinner H6 SoC.
>
> The first 6 PATCHes are the USB2 part, and the latter 4 PATCHes are the
> USB3 part.
>
> PATCH 1, 2, 3, 7, 8 should go through the PHY tree, and the remaining
> patches should go through the armsoc tree via sunxi tree.
>
> Icenowy Zheng (10):
>   dt-bindings: phy: add binding for Allwinner H6 USB2 PHY
>   phy: sun4i-usb: add support for missing USB PHY index
>   phy: sun4i-usb: add support for H6 USB2 PHY
>   arm64: allwinner: dts: h6: add USB2-related device nodes
>   arm64: allwinner: dts: h6: add USB Vbus regulator
>   arm64: allwinner: dts: h6: enable USB2 on Pine H64
>   dt-bindings: phy: add binding for Allwinner USB3 PHY
>   phy: allwinner: add phy driver for USB3 PHY on Allwinner H6 SoC
>   arm64: allwinner: dts: h6: add USB3 device nodes
>   arm64: allwinner: dts: h6: enable USB3 port on Pine H64

Tested-by: Chen-Yu Tsai <wens@csie.org>
