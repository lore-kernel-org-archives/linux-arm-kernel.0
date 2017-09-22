From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 22 Sep 2017 09:49:45 +0200
Subject: [PATCH 02/12] ARM: dts: sunxi: h3/h5: Fix i2c2 register address
In-Reply-To: <20170921172151.29779-3-clabbe.montjoie@gmail.com>
References: <20170921172151.29779-1-clabbe.montjoie@gmail.com>
 <20170921172151.29779-3-clabbe.montjoie@gmail.com>
Message-ID: <20170922074945.jzibcgromgbhggxy@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 21, 2017 at 05:21:41PM +0000, Corentin Labbe wrote:
> The unit address and register address does not match.
> This patch fix the register address with the good one.
> 
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> ---
>  arch/arm/boot/dts/sunxi-h3-h5.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> index 59ddac9f65a7..37464d4d07f6 100644
> --- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> +++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> @@ -630,9 +630,9 @@
>  			#size-cells = <0>;
>  		};
>  
> -		i2c2: i2c at 01c2b400 {
> +		i2c2: i2c at 1c2b400 {

This one should be merged into the previous patch.

The serie looks good otherwise, onec it's fixed, you can add my
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170922/62b866d5/attachment.sig>
