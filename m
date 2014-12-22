From: balbi@ti.com (Felipe Balbi)
Date: Mon, 22 Dec 2014 14:38:54 -0600
Subject: [PATCH] ARM: dts: am437x-sk-evm: Hook dcdc2 as the cpu0-supply
In-Reply-To: <1417706679-22294-1-git-send-email-balbi@ti.com>
References: <1417706679-22294-1-git-send-email-balbi@ti.com>
Message-ID: <20141222203854.GD3083@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 04, 2014 at 09:24:39AM -0600, Felipe Balbi wrote:
> From: Dave Gerlach <d-gerlach@ti.com>
> 
> Hook dcdc2 as the cpu0-supply.
> 
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> Signed-off-by: Felipe Balbi <balbi@ti.com>

btw, before sending this, I tested on my AM437x Starter Kit, so

Tested-by: Felipe Balbi <balbi@ti.com>

> ---
>  arch/arm/boot/dts/am437x-sk-evm.dts | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am437x-sk-evm.dts b/arch/arm/boot/dts/am437x-sk-evm.dts
> index 87aa4f3..f7f77a7 100644
> --- a/arch/arm/boot/dts/am437x-sk-evm.dts
> +++ b/arch/arm/boot/dts/am437x-sk-evm.dts
> @@ -611,3 +611,7 @@
>  &wdt {
>  	status = "okay";
>  };
> +
> +&cpu {
> +	cpu0-supply = <&dcdc2>;
> +};
> -- 
> 2.1.0.GIT
> 

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141222/f957efd8/attachment.sig>
