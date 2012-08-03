From: balbi@ti.com (Felipe Balbi)
Date: Fri, 3 Aug 2012 16:21:39 +0300
Subject: [PATCH v2 2/2] arm/dts: omap4: Add ocp2scp data
In-Reply-To: <1342593039-7728-3-git-send-email-kishon@ti.com>
References: <1342593039-7728-1-git-send-email-kishon@ti.com>
 <1342593039-7728-3-git-send-email-kishon@ti.com>
Message-ID: <20120803132137.GB8269@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 18, 2012 at 12:00:39PM +0530, Kishon Vijay Abraham I wrote:
> Add ocp2scp data node in omap4 device tree file.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

Acked-by: Felipe Balbi <balbi@ti.com>

> ---
>  arch/arm/boot/dts/omap4.dtsi |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
> index 359c497..29c6243 100644
> --- a/arch/arm/boot/dts/omap4.dtsi
> +++ b/arch/arm/boot/dts/omap4.dtsi
> @@ -272,5 +272,13 @@
>  			ti,hwmods = "mmc5";
>  			ti,needs-special-reset;
>  		};
> +
> +		ocp2scp {
> +			compatible = "ti,omap-ocp2scp";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +			ti,hwmods = "ocp2scp_usb_phy";
> +		};
>  	};
>  };
> -- 
> 1.7.5.4
> 

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120803/3356c810/attachment.sig>
