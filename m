From: balbi@ti.com (Felipe Balbi)
Date: Mon, 27 Oct 2014 11:42:14 -0500
Subject: [PATCH v2 07/10] ARM: dts: tegra: Use standard power-off
 property in tps65911 for tegra30 apalis
In-Reply-To: <1414427215-14380-7-git-send-email-romain.perier@gmail.com>
References: <1414427215-14380-1-git-send-email-romain.perier@gmail.com>
 <1414427215-14380-7-git-send-email-romain.perier@gmail.com>
Message-ID: <20141027164214.GF14253@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 27, 2014 at 04:26:52PM +0000, Romain Perier wrote:
> Signed-off-by: Romain Perier <romain.perier@gmail.com>
> ---
>  arch/arm/boot/dts/tegra30-apalis.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/tegra30-apalis.dtsi
> index a5446cb..ced4436 100644
> --- a/arch/arm/boot/dts/tegra30-apalis.dtsi
> +++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
> @@ -412,7 +412,7 @@
>  			#interrupt-cells = <2>;
>  			interrupt-controller;
>  
> -			ti,system-power-controller;
> +			system-power-controller;

this board is broken until this patch is applied.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141027/2859fd67/attachment.sig>
