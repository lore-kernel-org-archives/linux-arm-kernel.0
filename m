From: robh@kernel.org (Rob Herring)
Date: Tue, 25 Sep 2018 04:24:39 -0700
Subject: [PATCH] arm64: dts: rockchip: add initial dts support for
 Rockpro64 board
In-Reply-To: <1537368206-22058-1-git-send-email-Akash_Gajjar@mentor.com>
References: <Akash_Gajjar@mentor.com>
 <1537368206-22058-1-git-send-email-Akash_Gajjar@mentor.com>
Message-ID: <5baa1af8.1c69fb81.b6252.4425@mx.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 19 Sep 2018 20:13:18 +0530, Akash Gajjar wrote:
> This patch basic node support for Rockpro64 board and make it able to bring up.
> 
> Peripheral Works
> - SDIO, Sdcard
> - USB 2.0, 3.0
> - Leds
> 
> Not working:
> - USB Type-C
> 
> Signed-off-by: Akash Gajjar <Akash_Gajjar@mentor.com>
> ---
> 
> Changes in v2:
> - add support for usb 2.0, 3.0
> - add fusb302 node and its regulator support
> - cleanup pinctrl node
> - remove backlight, pcie, sound codec node inherited from firefly-rk3399 dts
> 
>  Documentation/devicetree/bindings/arm/rockchip.txt |   4 +
>  arch/arm64/boot/dts/rockchip/Makefile              |   1 +
>  arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts  | 692 +++++++++++++++++++++
>  3 files changed, 697 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
> 

Reviewed-by: Rob Herring <robh@kernel.org>
