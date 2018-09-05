From: frowand.list@gmail.com (Frank Rowand)
Date: Wed, 5 Sep 2018 13:53:16 -0700
Subject: [RESEND PATCHv2 2/2] arm64: ti: add support for building Texas
 instruments overlays
In-Reply-To: <1536049651-10206-3-git-send-email-t-kristo@ti.com>
References: <1535722107-13767-1-git-send-email-t-kristo@ti.com>
 <1536049651-10206-1-git-send-email-t-kristo@ti.com>
 <1536049651-10206-3-git-send-email-t-kristo@ti.com>
Message-ID: <da954637-3eab-a48b-e608-f379a4572a1c@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/04/18 01:27, Tero Kristo wrote:
> Add the symbols to TI build DT files, for supporting overlays. Right now,
> there are no overlay files introduced, those shall be added later on.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>  arch/arm64/boot/dts/ti/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
> index 63e619d..753de8c 100644
> --- a/arch/arm64/boot/dts/ti/Makefile
> +++ b/arch/arm64/boot/dts/ti/Makefile
> @@ -6,4 +6,6 @@
>  # Copyright (C) 2016-2018 Texas Instruments Incorporated - http://www.ti.com/
>  #
>  
> +DTC_FLAGS += -@
> +
>  dtb-$(CONFIG_ARCH_K3_AM6_SOC) += k3-am654-base-board.dtb
> 

same comment as for patch 1/2
