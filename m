From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 12 Jul 2018 09:23:38 +0200
Subject: [PATCH 2/2] ARM: sun8i: h3: add SY8113B regulator on Banana Pi
 M2 Zero board
In-Reply-To: <20180711134450.43148-1-icenowy@aosc.io>
References: <20180711134450.43148-1-icenowy@aosc.io>
Message-ID: <20180712072338.zxhzm5rdhmlorjjj@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 11, 2018 at 09:44:50PM +0800, Icenowy Zheng wrote:
> Banana Pi M2 Zero board has a SY8113B regulator, which is controlled via
> GPIO and capable of outputing 1.1V when the PL1 GPIO is set to output 0
> or 1.1V when the PL6 GPIO is set to input or output 1, and the output is
> the power supply of the ARM cores in H3 SoC.
> 
> Add the device tree node of this regulator and set the cpu's cpu-supply
> property to it.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Applied, thanks!
Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180712/6ebef85c/attachment.sig>
