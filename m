From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 19 Oct 2015 20:04:36 +0200
Subject: [PATCH v3] ARM: dts: sun6i: Add support for Sinlinx A31s SDK board
In-Reply-To: <1445097849-5735-1-git-send-email-wens@csie.org>
References: <1445097849-5735-1-git-send-email-wens@csie.org>
Message-ID: <20151019180436.GV2711@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 18, 2015 at 12:04:09AM +0800, Chen-Yu Tsai wrote:
> The Sinlinx A31s SDK is a A31s based module/baseboard development kit.
> 
> The core module has the SoC, PMIC, DRAM, eMMC and supporting components.
> There are also pads for UART0, JTAG and I2S.
> 
> The baseboard has 100 Mbps Ethernet, 5x USB 2.0 host ports via a USB 2.0
> hub chip, MMC, HDMI, SPDIF, CIR, audio jacks, 2 tablet-like volume
> buttons, RS232 style UART and USB OTG (though VBUS is not connected).
> Various headers are available for other addon modules, such as SDIO
> WiFi, LCD display, camera sensor, UARTs, I2C, SPI and GPIOs.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151019/35dac508/attachment.sig>
