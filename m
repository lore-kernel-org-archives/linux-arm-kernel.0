From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 24 Apr 2018 13:54:18 +0200
Subject: [PATCH 4/7] ARM: dts: sun8i: h2+: Add Libre Computer Board
 ALL-H3-CC H2+ ver.
In-Reply-To: <20180424113424.13196-5-wens@csie.org>
References: <20180424113424.13196-1-wens@csie.org>
 <20180424113424.13196-5-wens@csie.org>
Message-ID: <20180424115418.lpv4drajf4t32xss@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 24, 2018 at 07:34:21PM +0800, Chen-Yu Tsai wrote:
> This patch adds a device tree file for the H2+ version of the Libre
> Computer Board ALL-H3-CC. It is the same board first introduced in
> commit 6ca358645d4d ("ARM: dts: sun8i: h3: Add dts file for Libre
> Computer Board ALL-H3-CC H3 ver."), with the H3 SoC replaced with
> the H2+ SoC, and has only two 2Gb DDR3 chips instead of four.
> 
> The device tree utilizes the common board design file for ALL-H3-CC,
> providing just the model strings and SoC specifics.
> 
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180424/eeb57736/attachment.sig>
