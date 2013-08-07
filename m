From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 7 Aug 2013 12:38:07 -0400
Subject: [PATCH] ARM: dts: Fix memory node in skeleton64.dtsi
In-Reply-To: <1375839186-1904-1-git-send-email-stepanm@codeaurora.org>
References: <1375839186-1904-1-git-send-email-stepanm@codeaurora.org>
Message-ID: <20130807163807.GG19280@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 06, 2013 at 06:33:06PM -0700, Stepan Moskovchenko wrote:
> Update the reg property of the memory node in
> skeleton64.dtsi to reflect the fact that the root node uses
> address-cells=2 and size-cells=2.
> 
> Change-Id: Ie9b61166143969e020ceebc51e9a384405d8c0f2
> Signed-off-by: Stepan Moskovchenko <stepanm@codeaurora.org>
> ---
>  arch/arm/boot/dts/skeleton64.dtsi |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Applied to mvebu/fixes-non-critical with Gregory's Ack an Change-Id
removed.

thx,

Jason.

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
> -- 
> The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> hosted by The Linux Foundation
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
