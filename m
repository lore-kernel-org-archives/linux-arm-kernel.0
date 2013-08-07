From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 07 Aug 2013 08:23:06 +0200
Subject: [PATCH] ARM: dts: Fix memory node in skeleton64.dtsi
In-Reply-To: <1375839186-1904-1-git-send-email-stepanm@codeaurora.org>
References: <1375839186-1904-1-git-send-email-stepanm@codeaurora.org>
Message-ID: <5201E7CA.4050601@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/08/2013 03:33, Stepan Moskovchenko wrote:
> Update the reg property of the memory node in
> skeleton64.dtsi to reflect the fact that the root node uses
> address-cells=2 and size-cells=2.

Good catch

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

> 
> Change-Id: Ie9b61166143969e020ceebc51e9a384405d8c0f2
> Signed-off-by: Stepan Moskovchenko <stepanm@codeaurora.org>
> ---
>  arch/arm/boot/dts/skeleton64.dtsi |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/skeleton64.dtsi b/arch/arm/boot/dts/skeleton64.dtsi
> index 1599415..b5d7f36 100644
> --- a/arch/arm/boot/dts/skeleton64.dtsi
> +++ b/arch/arm/boot/dts/skeleton64.dtsi
> @@ -9,5 +9,5 @@
>  	#size-cells = <2>;
>  	chosen { };
>  	aliases { };
> -	memory { device_type = "memory"; reg = <0 0>; };
> +	memory { device_type = "memory"; reg = <0 0 0 0>; };
>  };
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
