From: balbi@ti.com (Felipe Balbi)
Date: Mon, 27 Oct 2014 11:42:42 -0500
Subject: [PATCH v2 08/10] ARM: dts: tegra: Use standard power-off
 property in tps65911 for tegra30 beaver
In-Reply-To: <1414427215-14380-8-git-send-email-romain.perier@gmail.com>
References: <1414427215-14380-1-git-send-email-romain.perier@gmail.com>
 <1414427215-14380-8-git-send-email-romain.perier@gmail.com>
Message-ID: <20141027164242.GG14253@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 27, 2014 at 04:26:53PM +0000, Romain Perier wrote:
> Signed-off-by: Romain Perier <romain.perier@gmail.com>
> ---
>  arch/arm/boot/dts/tegra30-beaver.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/tegra30-beaver.dts b/arch/arm/boot/dts/tegra30-beaver.dts
> index cee8f22..4abaf7f 100644
> --- a/arch/arm/boot/dts/tegra30-beaver.dts
> +++ b/arch/arm/boot/dts/tegra30-beaver.dts
> @@ -188,7 +188,7 @@
>  			#interrupt-cells = <2>;
>  			interrupt-controller;
>  
> -			ti,system-power-controller;
> +			system-power-controller;

and this... likewise to all others. You should add regressions midway
through your series and you can't simply drop a DT binding which has
been shipped on stable kernels.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141027/f7948ba7/attachment-0001.sig>
