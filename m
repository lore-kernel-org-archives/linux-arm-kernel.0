From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 28 Aug 2015 14:34:43 +0200
Subject: [PATCH 5/6] ARM: dts: sun6i: Add support for Sinlinx A31s SDK
 board
In-Reply-To: <1440755679-8266-6-git-send-email-wens@csie.org>
References: <1440755679-8266-1-git-send-email-wens@csie.org>
 <1440755679-8266-6-git-send-email-wens@csie.org>
Message-ID: <20150828123443.GM29389@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 28, 2015 at 05:54:38PM +0800, Chen-Yu Tsai wrote:
> The Sinlinx A31s SDK is a A31s based module/baseboard development kit.
> 
> The core module has the SoC, PMIC, DRAM, eMMC and supporting components.
> There are also pads for UART0, JTAG and I2S.

Can you use that core module without that baseboard?

> The baseboard has 100 Mbps Ethernet, 5x USB 2.0 host ports via a USB 2.0
> hub chip, MMC, HDMI, SPDIF, CIR, audio jacks, 2 tablet-like volume
> buttons, RS232 style UART and USB OTG (though VBUS is not connected).
> Various headers are available for other addon modules, such as SDIO
> WiFi, LCD display, camera sensor, UARTs, I2C, SPI and GPIOs.

Can the baseboard be used with our core modules?

Thanks,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150828/d55d427f/attachment.sig>
