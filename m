From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 22 Jan 2018 11:40:47 +0100
Subject: [PATCH v2] arm64: dts: rockchip: add roc-rk3328-cc board
In-Reply-To: <20180120095404.32117-1-djw@t-chip.com.cn>
References: <20180106094538.15568-1-djw@t-chip.com.cn>
 <20180120095404.32117-1-djw@t-chip.com.cn>
Message-ID: <1977166.SIloaIvObo@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Levin,

Am Samstag, 20. Januar 2018, 17:54:04 CET schrieb djw at t-chip.com.cn:
> From: Levin Du <djw@t-chip.com.cn>
> 
> Hi all,
>   This version uses SPDX license tag.
> 
> The roc-rk3328-cc is a credit card size single board computer using the
> Rockchip RK3328 Quad-Core ARM Cortex A53 64-Bit Processor and supporting
> up to 2GB 2133MHz LPDDR4 memory. It provides eMMC module socket, MicroSD
> Card slot, USB 2.0/3.0, Gigabit Ethernet, HDMI/CVBS, Infrared Receiver,
> SPDIF/I2S, and SPI/I2C/UART/PWM interfaces.
> 
> The devicetree currently supports basic peripherals.
> 
> Signed-off-by: Levin Du <djw@t-chip.com.cn>

> +&i2c1 {
> +	status = "okay";
> +
> +	rk805: rk805 at 18 {

As noted by Rob in his review, this should be
	rk805: pmic at 18 {

While I'd normally just change that myself when applying it looks like
you also got comments from Andy to address, so you could change this too.


Thanks
Heiko
