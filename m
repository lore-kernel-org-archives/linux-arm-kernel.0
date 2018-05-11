From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 11 May 2018 10:01:54 +0200
Subject: [PATCH v4 3/3] ARM: dts: sun8i: h3: Add SY8106A regulator to
 Orange Pi PC
In-Reply-To: <20180507122942.25758-4-icenowy@aosc.io>
References: <20180507122942.25758-1-icenowy@aosc.io>
 <20180507122942.25758-4-icenowy@aosc.io>
Message-ID: <20180511080154.iubx6jidtxdojgfx@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 07, 2018 at 08:29:42PM +0800, Icenowy Zheng wrote:
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

Dropped Chen-Yu's SoB and applied, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180511/a86fc707/attachment.sig>
