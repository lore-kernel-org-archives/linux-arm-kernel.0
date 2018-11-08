From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 8 Nov 2018 09:25:22 +0100
Subject: [PATCH 15/15] arm64: dts: allwinner: a64: bananapi-m64: Add
 Bluetooth device node
In-Reply-To: <20181107101308.7626-16-wens@csie.org>
References: <20181107101308.7626-1-wens@csie.org>
 <20181107101308.7626-16-wens@csie.org>
Message-ID: <20181108082522.va5c63sb6t7zphpm@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 07, 2018 at 06:13:08PM +0800, Chen-Yu Tsai wrote:
> The AP6212 is based on the Broadcom BCM43430 or BCM43438. The WiFi side
> identifies as BCM43430, while the Bluetooth side identifies as BCM43438.
> 
> The Bluetooth side is connected to UART1 in a 4 wire configuration. Same
> as the WiFi side, due to being the same chip and package, DLDO2 provides
> overall power via VBAT, and DLDO4 provides I/O power via VDDIO. The RTC
> clock output provides the LPO low power clock at 32.768 kHz.
> 
> This patch enables Bluetooth on this board, and also adds the missing
> LPO clock on the WiFi side. There is also a PCM connection for Bluetooth,
> but this is not covered here.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Thanks for figuring this out!

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181108/d05e883b/attachment.sig>
