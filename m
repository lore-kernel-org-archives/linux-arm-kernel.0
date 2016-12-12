From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 12 Dec 2016 12:40:05 +0000
Subject: [PATCH v7 1/8] Documentation: arm: define DT cpu
 capacity-dmips-mhz bindings
In-Reply-To: <1473085372-2840-2-git-send-email-juri.lelli@arm.com>
References: <1473085372-2840-1-git-send-email-juri.lelli@arm.com>
 <1473085372-2840-2-git-send-email-juri.lelli@arm.com>
Message-ID: <20161212124005.GA19177@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 05, 2016 at 03:22:45PM +0100, Juri Lelli wrote:

[...]

> +===========================================
> +5 - References
> +===========================================
> +
> +[1] ARM Linux Kernel documentation - CPUs bindings
> +    Documentation/devicetree/bindings/arm/cpus.txt
> diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
> index e6782d50cbcd..c1dcf4cade2e 100644
> --- a/Documentation/devicetree/bindings/arm/cpus.txt
> +++ b/Documentation/devicetree/bindings/arm/cpus.txt
> @@ -241,6 +241,14 @@ nodes to be present and contain the properties described below.
>  			# List of phandles to idle state nodes supported
>  			  by this cpu [3].
>  
> +	- capacity-dmips-mhz
> +		Usage: Optional
> +		Value type: <u32>
> +		Definition:
> +			# u32 value representing CPU capacity [3] in
> +			  DMIPS/MHz, relative to highest capacity-dmips-mhz
> +			  in the system.
> +
>  	- rockchip,pmu
>  		Usage: optional for systems that have an "enable-method"
>  		       property value of "rockchip,rk3066-smp"
> @@ -464,3 +472,5 @@ cpus {
>  [2] arm/msm/qcom,kpss-acc.txt
>  [3] ARM Linux kernel documentation - idle states bindings
>      Documentation/devicetree/bindings/arm/idle-states.txt
> +[3] ARM Linux kernel documentation - cpu capacity bindings
> +    Documentation/devicetree/bindings/arm/cpu-capacity.txt

Trivia: bumped into this while reviewing something else, too many
threes, you will have to fix the added reference up.

Thanks,
Lorenzo
