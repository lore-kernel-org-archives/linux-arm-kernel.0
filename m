From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 22 Jun 2018 16:20:21 +0200
Subject: [PATCH v4 12/19] ARM: sun8i-a33: Add SRAM controller node and C1
 SRAM region
In-Reply-To: <20180618145843.14631-13-paul.kocialkowski@bootlin.com>
References: <20180618145843.14631-1-paul.kocialkowski@bootlin.com>
 <20180618145843.14631-13-paul.kocialkowski@bootlin.com>
Message-ID: <20180622142021.fatrwqqsdjxv2cbq@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 18, 2018 at 04:58:36PM +0200, Paul Kocialkowski wrote:
> From: Maxime Ripard <maxime.ripard@bootlin.com>
> 
> This adds a SRAM controller node for the A33, with support for the C1
> SRAM region that is shared between the Video Engine and the CPU.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> 
> diff --git a/arch/arm/boot/dts/sun8i-a33.dtsi b/arch/arm/boot/dts/sun8i-a33.dtsi
> index a21f2ed07a52..97a976b3b1ef 100644
> --- a/arch/arm/boot/dts/sun8i-a33.dtsi
> +++ b/arch/arm/boot/dts/sun8i-a33.dtsi

This should be in the common DTSI between the A23 and A33.

Thnaks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180622/c7a150cf/attachment.sig>
