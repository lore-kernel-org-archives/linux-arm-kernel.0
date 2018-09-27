From: robh@kernel.org (Rob Herring)
Date: Thu, 27 Sep 2018 15:02:51 -0500
Subject: [PATCH v3] arm64: dts: rockchip: add initial dts support for
 Rockpro64
In-Reply-To: <1537943105-21247-1-git-send-email-Akash_Gajjar@mentor.com>
References: <Akash_Gajjar@mentor.com>
 <1537943105-21247-1-git-send-email-Akash_Gajjar@mentor.com>
Message-ID: <20180927200251.GA4060@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 26 Sep 2018 11:54:57 +0530, Akash Gajjar wrote:
> Rockpro64 is a rockchip RK3399 based board from pine64.org.
> This patch adds basic device node support for Rockpro64 board and make it able
> to bring up.
> 
> Peripheral Works
> - Sdcard
> - USB 2.0, 3.0
> - Leds
> - Ethernet
> - Debug console
> 
> Not working:
> - USB Type-C
> 
> Signed-off-by: Akash Gajjar <Akash_Gajjar@mentor.com>
> ---
> changes for v2
> - Added support for usb 2.0, 3.0
> - Added fusb302 node and its regulator support
> - Cleanup pinctrl node
> - Remove backlight, pcie, sound codec node inherited from firefly-rk3399 dts
> changes for v3
> - Added copyright properly
> - Typo correction in commit message
> 
>  Documentation/devicetree/bindings/arm/rockchip.txt |   4 +
>  arch/arm64/boot/dts/rockchip/Makefile              |   1 +
>  arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts  | 692 +++++++++++++++++++++
>  3 files changed, 697 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
> 

Reviewed-by: Rob Herring <robh@kernel.org>
