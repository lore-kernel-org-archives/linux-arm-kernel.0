From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 11 Nov 2016 09:34:37 +0100
Subject: [PATCH v2 1/3] pinctrl: sunxi: Fix
 PIN_CONFIG_BIAS_PULL_{DOWN,UP} argument
In-Reply-To: <20161111024455.16883-2-wens@csie.org>
References: <20161111024455.16883-1-wens@csie.org>
 <20161111024455.16883-2-wens@csie.org>
Message-ID: <20161111083437.i3iotrwpjvpzmi2h@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 11, 2016 at 10:44:53AM +0800, Chen-Yu Tsai wrote:
> According to pinconf-generic.h, the argument for
> PIN_CONFIG_BIAS_PULL_{DOWN,UP} is non-zero if the bias is enabled
> with a pull up/down resistor, zero if it is directly connected
> to VDD or ground.
> 
> Since Allwinner hardware uses a weak pull resistor internally,
> the argument should be 1.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161111/bc2bfaf0/attachment.sig>
