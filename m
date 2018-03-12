From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 12 Mar 2018 09:46:27 +0100
Subject: [PATCH] ARM: dts: sun8i: reference tablet design: Enable PMIC
 power supplies
In-Reply-To: <20180312042116.18513-1-wens@csie.org>
References: <20180312042116.18513-1-wens@csie.org>
Message-ID: <20180312084627.ls4xxmvlkhqwf4ok@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 12, 2018 at 12:21:16PM +0800, Chen-Yu Tsai wrote:
> The A23/A33 reference tablet design has a DC barrel tied to the ACIN
> of the PMIC. And being a tablet, it has a Li-Po battery.
> 
> Enable both power supplies in the device tree.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180312/299fb73c/attachment.sig>
