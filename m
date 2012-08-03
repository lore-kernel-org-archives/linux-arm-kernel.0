From: balbi@ti.com (Felipe Balbi)
Date: Fri, 3 Aug 2012 16:27:39 +0300
Subject: [PATCH v6 02/11] arm/dts: omap: Add omap-usb2 dt data
In-Reply-To: <1343639400-28725-3-git-send-email-kishon@ti.com>
References: <1343639400-28725-1-git-send-email-kishon@ti.com>
 <1343639400-28725-3-git-send-email-kishon@ti.com>
Message-ID: <20120803132737.GD8269@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 30, 2012 at 02:39:51PM +0530, Kishon Vijay Abraham I wrote:
> Add omap-usb2 data node in omap4 device tree file.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

looks good:

Acked-by: Felipe Balbi <balbi@ti.com>

> ---
>  arch/arm/boot/dts/omap4.dtsi |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
> index 29c6243..15f1890 100644
> --- a/arch/arm/boot/dts/omap4.dtsi
> +++ b/arch/arm/boot/dts/omap4.dtsi
> @@ -279,6 +279,11 @@
>  			#size-cells = <1>;
>  			ranges;
>  			ti,hwmods = "ocp2scp_usb_phy";
> +			usb2phy at 4a0ad080 {
> +				compatible = "ti,omap-usb2";
> +				reg = <0x4a0ad080 0x58>,
> +				      <0x4a002300 0x1>;
> +			};
>  		};
>  	};
>  };
> -- 
> 1.7.9.5
> 

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120803/9196615d/attachment.sig>
