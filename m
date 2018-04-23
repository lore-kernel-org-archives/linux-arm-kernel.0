From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 23 Apr 2018 17:03:09 +0200
Subject: [PATCH v3 3/3] ARM: dts: sun8i: h3: Add SY8106A regulator to
 Orange Pi PC
In-Reply-To: <20180423144657.63264-4-icenowy@aosc.io>
References: <20180423144657.63264-1-icenowy@aosc.io>
 <20180423144657.63264-4-icenowy@aosc.io>
Message-ID: <20180423150309.dksr2rjazlrmlzx2@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 23, 2018 at 10:46:57PM +0800, Icenowy Zheng wrote:
> From: Ondrej Jirman <megous@megous.com>
> 
> Add SY8106A regulator to r_i2c bus and enable the r_i2c bus on
> Orange Pi PC, then set the power supply of the ARM cores to this
> regulator, in order to enable DVFS.
> 
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> [Icenowy: Enable DVFS in this patch, slight changes and change commit
>  message]
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> [wens at csie.org: Rename regulator label]
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Why is there Chen-Yu's SoB? It doesn't really make much sense, unless
Chen-Yu would have applied this patch already, but then you wouldn't
post it, right?

Maxime 

> ---

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180423/8a982140/attachment.sig>
