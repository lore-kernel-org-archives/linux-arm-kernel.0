From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 17 Jan 2016 13:23:56 +0100
Subject: [PATCH 3/3] ARM: dts: sun8i: Add device tree for Cubietruck Plus
In-Reply-To: <1452961497-10804-4-git-send-email-wens@csie.org>
References: <1452961497-10804-1-git-send-email-wens@csie.org>
 <1452961497-10804-4-git-send-email-wens@csie.org>
Message-ID: <20160117122356.GK4581@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 17, 2016 at 12:24:57AM +0800, Chen-Yu Tsai wrote:
> Cubietruck Plus is a A83T/H8 based development board. The board has
> standard DDR3 SDRAM, AXP818 PMIC/codec, SD/MMC, eMMC, USB 2.0 host
> via HSIC USB Hub, USB OTG, SATA via USB bridge, gigabit ethernet,
> WiFi, headphone out / mic in, and various GPIO headers.
> 
> The board also has an EEPROM on i2c0 which holds the MAC address.

Time to use the nvmem framework then ;)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160117/be5f4bf3/attachment.sig>
