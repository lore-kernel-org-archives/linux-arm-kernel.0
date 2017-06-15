From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 15 Jun 2017 18:27:03 +0200
Subject: [PATCH v2 2/3] arm64: dts: marvell: remove cpm crypto nodes from
 dts files
In-Reply-To: <20170615121004.32257-2-antoine.tenart@free-electrons.com>
 (Antoine Tenart's message of "Thu, 15 Jun 2017 14:10:03 +0200")
References: <20170615121004.32257-1-antoine.tenart@free-electrons.com>
 <20170615121004.32257-2-antoine.tenart@free-electrons.com>
Message-ID: <87a8596wtk.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Antoine,
 
 On jeu., juin 15 2017, Antoine Tenart <antoine.tenart@free-electrons.com> wrote:

> The cryptographic engine on the master cp110 is now enabled by default
> at the SoC level. Remove its dts nodes that were only enabling it.
>
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>


Applied on mvebu/dt64

Thanks,

Gregory

> ---
>  arch/arm64/boot/dts/marvell/armada-7040-db.dts | 4 ----
>  arch/arm64/boot/dts/marvell/armada-8040-db.dts | 4 ----
>  2 files changed, 8 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-7040-db.dts b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
> index 771311051421..92c761c380d3 100644
> --- a/arch/arm64/boot/dts/marvell/armada-7040-db.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
> @@ -187,7 +187,3 @@
>  	phy = <&phy1>;
>  	phy-mode = "rgmii-id";
>  };
> -
> -&cpm_crypto {
> -	status = "okay";
> -};
> diff --git a/arch/arm64/boot/dts/marvell/armada-8040-db.dts b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
> index 6af3c39bbb99..1e8f7242ed6f 100644
> --- a/arch/arm64/boot/dts/marvell/armada-8040-db.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
> @@ -142,10 +142,6 @@
>  	phy-mode = "rgmii-id";
>  };
>  
> -&cpm_crypto {
> -	status = "okay";
> -};
> -
>  /* CON5 on CP1 expansion */
>  &cps_pcie2 {
>  	status = "okay";
> -- 
> 2.9.4
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
