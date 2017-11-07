From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 7 Nov 2017 14:03:31 +0100
Subject: [PATCH 1/1] add rgb888 pins to a20 to enable parallel rgb LCD
In-Reply-To: <1510058999-6778-1-git-send-email-giulio.benetti@micronovasrl.com>
References: <1510058999-6778-1-git-send-email-giulio.benetti@micronovasrl.com>
Message-ID: <20171107130331.4wut5g6znzakkg4z@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 07, 2017 at 01:49:59PM +0100, Giulio Benetti wrote:
> On sun7i-a20-* there's no way to enable PA00--PA27 as RGB888 LCD0 pins.
> 
> Add lcd_rgb888_pins in sun7i-a20.dtsi.
> 
> It can be used on sun7i-a20-olinuxino-lime.dts.
> This patch gives possibility to set parallel lcd pins for RGB888.
> To be used with tcon0 in your <target>.dts

My question was on which board do you want to use it right now. If the
answer is none, then we won't merge that patch, we have too many
pinctrl already to not add the unused ones.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171107/4befc79b/attachment.sig>
