From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Sun, 18 Mar 2018 21:22:51 +0100
Subject: [PATCHv2 5/5] arm64: allwinner: a64: Add support for TERES-I
 laptop
In-Reply-To: <20180315162510.11669-6-harald@ccbib.org>
References: <20180315162510.11669-1-harald@ccbib.org>
 <20180315162510.11669-6-harald@ccbib.org>
Message-ID: <20180318202251.5gpv6sblfr4edxmj@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 15, 2018 at 04:25:10PM +0000, Harald Geyer wrote:
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		capslock {
> +			label = "leds:green:capslock";

The first part is supposed to be the name of the boards. I did sed
s/leds/teres-i/, and applied, together with all the patches but the
PWM (so I had to drop the backlight node as well).

Please coordinate with Andre about who should send the PWM support.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180318/372d6232/attachment-0001.sig>
