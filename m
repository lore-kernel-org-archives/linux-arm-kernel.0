From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 24 Apr 2018 14:13:53 +0200
Subject: [PATCH 2/7] ARM: dts: sun8i: h3: Split out common board design
 for ALL-H3-CC
In-Reply-To: <20180424113424.13196-3-wens@csie.org>
References: <20180424113424.13196-1-wens@csie.org>
 <20180424113424.13196-3-wens@csie.org>
Message-ID: <20180424121353.zxujyehsw3er2xq6@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 24, 2018 at 07:34:19PM +0800, Chen-Yu Tsai wrote:
> The Libre Computer Project ALL-H3-CC has three models, all using the
> same board design, but with different pin compatible SoCs and amount of
> DRAM.
> 
> Currently only the H3 1GB DRAM variant is supported. To support the two
> other variants, first split the original device tree into a common board
> design part and an SoC specific part.
> 
> The SoC part only defines which SoC is used and model name, and includes
> the SoC specific dtsi file and the common design dtsi file.
> 
> Also fix up the SPDX identifier line to use the correct comment style,
> and place it on the first line.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  .../boot/dts/sun8i-h3-libretech-all-h3-cc.dts | 213 +-----------------
>  ....dts => sunxi-hx-libretech-all-h3-cc.dtsi} |  11 +-

I think I prefer the name of Neil's DTSI better, and since pretty much
the same patches (a couple of hours) before, we'll merge them (while
merging the rest of your patches, obviously).

Does that work for you?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180424/217c3fad/attachment.sig>
