From: robh@kernel.org (Rob Herring)
Date: Mon, 29 Jan 2018 17:21:27 -0600
Subject: [PATCH v3] arm64: dts: rockchip: add roc-rk3328-cc board
In-Reply-To: <20180123021017.24110-1-djw@t-chip.com.cn>
References: <20180106094538.15568-1-djw@t-chip.com.cn>
 <20180123021017.24110-1-djw@t-chip.com.cn>
Message-ID: <20180129232127.unanaujy44q42bul@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 23, 2018 at 10:10:17AM +0800, djw at t-chip.com.cn wrote:
> From: Levin Du <djw@t-chip.com.cn>
> 
> Hi all,
> 
> v3:
> Use pmic at 18 instead of rk805 at 18
> Use macro definition RK_Pxx in gpio number
> 
> v2:
> Use SPDX license tag
> 
> Thanks.

All of this above belongs below the '---' so it is not in the commit 
msg.

Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>

> The roc-rk3328-cc is a credit card size single board computer using the
> Rockchip RK3328 Quad-Core ARM Cortex A53 64-Bit Processor and supporting
> up to 2GB 2133MHz LPDDR4 memory. It provides eMMC module socket, MicroSD
> Card slot, USB 2.0/3.0, Gigabit Ethernet, HDMI/CVBS, Infrared Receiver,
> SPDIF/I2S, and SPI/I2C/UART/PWM interfaces.
> 
> The devicetree currently supports basic peripherals.
> 
> Signed-off-by: Levin Du <djw@t-chip.com.cn>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.txt |   4 +
>  arch/arm64/boot/dts/rockchip/Makefile              |   1 +
>  arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts     | 276 +++++++++++++++++++++
>  3 files changed, 281 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts
