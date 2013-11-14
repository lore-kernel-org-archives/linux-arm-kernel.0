From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 14 Nov 2013 16:36:50 +0100
Subject: [PATCH] ARM: orion5x: Fix typo in device_type property of phy node
In-Reply-To: <1384440788-3529-1-git-send-email-srinivas.kandagatla@st.com>
References: <1384440788-3529-1-git-send-email-srinivas.kandagatla@st.com>
Message-ID: <20131114153650.GK21691@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 14, 2013 at 02:53:08PM +0000, Srinivas Kandagatla wrote:
> This patch fixes a typo for device_type property of phy node.
> This can work as of today but once a checks are added in generic code
> this typo will stop phy from working.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>

Hi Srinivas

Please CC: the Marvell maintainers for patches like this.
I added them in CC:

Acked-by: Andrew Lunn <andrew@lunn.ch>


> ---
>  .../dts/orion5x-lacie-ethernet-disk-mini-v2.dts    |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts b/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
> index aed83de..fcc5bb6 100644
> --- a/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
> +++ b/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
> @@ -58,7 +58,7 @@
>  	status = "okay";
>  
>  	ethphy: ethernet-phy {
> -		device-type = "ethernet-phy";
> +		device_type = "ethernet-phy";
>  		reg = <8>;
>  	};
>  };
> -- 
> 1.7.6.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
