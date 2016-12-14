From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 14 Dec 2016 16:30:13 +0100
Subject: [PATCH v2] ARM: dts: sunxi: Change node name for pwrseq pin on
 Olinuxino-lime2-emmc
In-Reply-To: <20161214145724.42745-1-manu@bidouilliste.com>
References: <20161214145724.42745-1-manu@bidouilliste.com>
Message-ID: <20161214153013.bkdm3pu3osepfnn2@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 14, 2016 at 03:57:24PM +0100, Emmanuel Vadot wrote:
> The node name for the power seq pin is mmc2 at 0 like the mmc2_pins_a one.
> This makes the original node (mmc2_pins_a) scrapped out of the dtb and
> result in a unusable eMMC if U-Boot didn't configured the pins to the
> correct functions.
> 
> Changes since v1:
>  * Rename the node mmc2-rst-pin

That changelog should be after the ---. Removed it and applied.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161214/2918b004/attachment.sig>
