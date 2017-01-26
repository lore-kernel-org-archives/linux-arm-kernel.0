From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 26 Jan 2017 11:38:13 +0100
Subject: [PATCH 08/11] ARM: dts: sun8i-a23-q8-tablet: Drop pinmux setting
 for codec PA gpio
In-Reply-To: <20170124023230.3990-9-wens@csie.org>
References: <20170124023230.3990-1-wens@csie.org>
 <20170124023230.3990-9-wens@csie.org>
Message-ID: <20170126103813.6k6zqnjvguiphs5s@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 24, 2017 at 10:32:27AM +0800, Chen-Yu Tsai wrote:
> We are moving towards handling GPIO pinmux settings that don't require
> extra bias or drive strength settings to use the GPIO bindings only.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  arch/arm/boot/dts/sun8i-a23-q8-tablet.dts | 10 ----------
>  drivers/clk/sunxi-ng/ccu-sun9i-a80.c      | 24 ++++++++++++------------

That diff looks suspicious :)

(and the patch for which you wrote a commit log for
doesn't have anything to do in this serie)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170126/5bae6cc0/attachment.sig>
