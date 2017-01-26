From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 26 Jan 2017 11:21:45 +0100
Subject: [PATCH 09/11] ARM: dts: sunxi: Remove no longer used
 pinctrl/sun4i-a10.h header
In-Reply-To: <20170124023230.3990-10-wens@csie.org>
References: <20170124023230.3990-1-wens@csie.org>
 <20170124023230.3990-10-wens@csie.org>
Message-ID: <20170126102145.35dfx6q6lpxdt72c@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 24, 2017 at 10:32:28AM +0800, Chen-Yu Tsai wrote:
> All dts files for the sunxi platform have been switched to the generic
> pinconf bindings. As a result, the sunxi specific pinctrl macros are
> no longer used.
> 
> Remove the #include entry with the following command:
> 
>     sed -i -e '/pinctrl\/sun4i-a10.h/D' arch/arm/boot/dts/sun?i*.*
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170126/0f4f6fe6/attachment-0001.sig>
