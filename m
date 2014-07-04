From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 4 Jul 2014 09:08:53 +0200
Subject: [PATCH] pinctrl: sunxi: Remove gpio_out function from sun5i-a13
 PG0/1/2 pins
In-Reply-To: <1404228308-22783-1-git-send-email-wens@csie.org>
References: <1404228308-22783-1-git-send-email-wens@csie.org>
Message-ID: <20140704070853.GJ31996@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jul 01, 2014 at 11:25:08PM +0800, Chen-Yu Tsai wrote:
> The A13 user manual states pins PG0/1/2 only have GPIO input and
> interrupt functions. Remove the gpio_out functions for these pins.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Good catch!

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140704/8008aa6f/attachment.sig>
