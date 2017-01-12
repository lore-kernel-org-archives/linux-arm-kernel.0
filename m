From: tony@atomide.com (Tony Lindgren)
Date: Thu, 12 Jan 2017 13:52:48 -0800
Subject: [PATCH] ARM: dts: dra72-evm-revc: fix typo in ethernet-phy node
In-Reply-To: <6027fbe6a797e840e57e25a35273aff39e2e00a7.1484218375.git.nsekhar@ti.com>
References: <6027fbe6a797e840e57e25a35273aff39e2e00a7.1484218375.git.nsekhar@ti.com>
Message-ID: <20170112215247.GL2630@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Sekhar Nori <nsekhar@ti.com> [170112 02:55]:
> Fix a typo in impedance setting for ethernet-phy at 3
> 
> Fixes: b76db38cd8ae ("ARM: dts: dra72-evm-revc: add phy impedance settings")
> Cc: Mugunthan V N <mugunthanvnm@ti.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> ---
>  arch/arm/boot/dts/dra72-evm-revc.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/dra72-evm-revc.dts b/arch/arm/boot/dts/dra72-evm-revc.dts
> index c3d939c9666c..3f808a47df03 100644
> --- a/arch/arm/boot/dts/dra72-evm-revc.dts
> +++ b/arch/arm/boot/dts/dra72-evm-revc.dts
> @@ -75,6 +75,6 @@
>  		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_25_NS>;
>  		ti,tx-internal-delay = <DP83867_RGMIIDCTL_250_PS>;
>  		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_8_B_NIB>;
> -		ti,min-output-imepdance;
> +		ti,min-output-impedance;
>  	};
>  };

Applying into omap-for-v4.10/fixes thanks.

Tony
