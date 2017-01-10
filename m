From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 10 Jan 2017 19:21:06 +0100
Subject: [PATCH 4/5] ARM: dts: sunxi: add dtsi file for V3s SoC
In-Reply-To: <20170103151629.19447-5-icenowy@aosc.xyz>
References: <20170103151629.19447-1-icenowy@aosc.xyz>
 <20170103151629.19447-5-icenowy@aosc.xyz>
Message-ID: <20170110182106.7q7uduxxqbzg4squ@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 03, 2017 at 11:16:28PM +0800, Icenowy Zheng wrote:
> +			uart0_pins_a: uart0 at 0 {
> +				pins = "PB8", "PB9";
> +				function = "uart0";
> +				bias-pull-up;

Why do you need a pullup here?

Looks good otherwise.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170110/381e01e3/attachment.sig>
