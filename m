From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 8 Feb 2018 16:11:55 +0100
Subject: [PATCH v5] ARM: sun8i: h2+: add support for Banana Pi M2 Zero
 board
In-Reply-To: <20180208100613.4761-1-icenowy@aosc.io>
References: <20180208100613.4761-1-icenowy@aosc.io>
Message-ID: <20180208151155.ncmsoeofjjj6nrid@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 08, 2018 at 06:06:13PM +0800, Icenowy Zheng wrote:
> Banana Pi M2 Zero board is a H2+-based board by Sinovoip, with a form
> factor and GPIO holes similar to Raspberry Pi Zero.
> 
> It features:
> - Allwinner H2+ SoC
> - Single-chip (16-bit) 512MiB DDR3 DRAM
> - Ampak AP6212 Wi-Fi/Bluetooth module
> - MicroSD slot
> - Two MicroUSB Type-B ports (one can only be used to power the board and
>   the other features OTG functionality)
> - Two keys, a reset and a GPIO-connected key.
> - HDMI Type-C (miniHDMI) connector connected to the HDMI part of H2+.
> - CSI connector to connect the camera sensor provided by Sinovoip.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Applied, thanks!
Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180208/2be443a3/attachment.sig>
