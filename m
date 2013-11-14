From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 14 Nov 2013 16:37:25 +0100
Subject: [PATCH] ARM: dove: Fix typo in device_type property of phy node
In-Reply-To: <1384440899-3622-1-git-send-email-srinivas.kandagatla@st.com>
References: <1384440899-3622-1-git-send-email-srinivas.kandagatla@st.com>
Message-ID: <20131114153725.GL21691@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 14, 2013 at 02:54:59PM +0000, Srinivas Kandagatla wrote:
> This patch fixes a typo for device_type property of phy node.
> This can work as of today but once a checks are added in generic code
> this typo will stop phy from working.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>

Acked-by: Andrew Lunn <andrew@lunn.ch>

> ---
>  arch/arm/boot/dts/dove.dtsi |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
> index cc27916..b4a6559 100644
> --- a/arch/arm/boot/dts/dove.dtsi
> +++ b/arch/arm/boot/dts/dove.dtsi
> @@ -481,7 +481,7 @@
>  			status = "disabled";
>  
>  			ethphy: ethernet-phy {
> -				device-type = "ethernet-phy";
> +				device_type = "ethernet-phy";
>  				/* set phy address in board file */
>  			};
>  		};
> -- 
> 1.7.6.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
