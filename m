From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 12 Oct 2015 11:30:34 +0200
Subject: [PATCH v2 5/5] ARM: dts: sun6i: Add support for Sinlinx A31s SDK
 board
In-Reply-To: <1444488540-11263-6-git-send-email-wens@csie.org>
References: <1444488540-11263-1-git-send-email-wens@csie.org>
 <1444488540-11263-6-git-send-email-wens@csie.org>
Message-ID: <20151012093034.GZ2278@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Oct 10, 2015 at 10:49:00PM +0800, Chen-Yu Tsai wrote:
> +&i2c0 {
> +	/* Available on camera header */
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c0_pins_a>;
> +	status = "okay";
> +};
> +
> +&i2c1 {
> +	/* Available on LCD header */
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c1_pins_a>;
> +	status = "okay";
> +};

Are those two actually used anywhere on the board itself, or just
exposed on the pin headers?

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151012/722fb7be/attachment.sig>
