From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 24 Apr 2018 13:52:21 +0200
Subject: [PATCH 1/7] ARM: dts: sun8i: h3: fix ALL-H3-CC H3 ver VCC-1V2
 regulator voltage
In-Reply-To: <20180424113424.13196-2-wens@csie.org>
References: <20180424113424.13196-1-wens@csie.org>
 <20180424113424.13196-2-wens@csie.org>
Message-ID: <20180424115221.tlb6r44u2drz7hnn@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 24, 2018 at 07:34:18PM +0800, Chen-Yu Tsai wrote:
> The voltage of the VCC-1V2 regulator on the ALL-H3-CC H3 ver. should be
> 1.2V, not the 3.3V currently defined in the device tree.
> 
> Fix the voltage in the device tree.
> 
> Fixes: 6ca358645d4d ("ARM: dts: sun8i: h3: Add dts file for Libre
> 		      Computer Board ALL-H3-CC H3 ver.")
> Cc: <stable@vger.kernel.org> # 4.16.x
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180424/7012f677/attachment.sig>
