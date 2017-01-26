From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 26 Jan 2017 11:15:29 +0100
Subject: [PATCH 10/11] arm64: dts: allwinner: Remove no longer used
 pinctrl/sun4i-a10.h header
In-Reply-To: <20170124023230.3990-11-wens@csie.org>
References: <20170124023230.3990-1-wens@csie.org>
 <20170124023230.3990-11-wens@csie.org>
Message-ID: <20170126101529.j3fuku4hyy3pbge3@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 24, 2017 at 10:32:29AM +0800, Chen-Yu Tsai wrote:
> All dts files for the sunxi platform have been switched to the generic
> pinconf bindings. As a result, the sunxi specific pinctrl macros are
> no longer used.
> 
> Remove the #include entry with the following command:
> 
>     sed -i -e '/pinctrl\/sun4i-a10.h/D' \
> 	arch/arm64/boot/dts/allwinner/*.dts?
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!

Maybe we should also remove the header entirely?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170126/4695a9d3/attachment.sig>
