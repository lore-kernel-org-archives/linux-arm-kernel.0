From: afaerber@suse.de (=?windows-1252?Q?Andreas_F=E4rber?=)
Date: Mon, 29 Sep 2014 16:46:45 +0200
Subject: [PATCH 3/6] arm64: dts/Makefile: Add support for Spreadtrum's
 Shark64 SoC.
In-Reply-To: <1411991314-6636-4-git-send-email-zhang.lyra@gmail.com>
References: <1411991314-6636-1-git-send-email-zhang.lyra@gmail.com>
 <1411991314-6636-4-git-send-email-zhang.lyra@gmail.com>
Message-ID: <542970D5.7010507@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am 29.09.2014 um 13:48 schrieb zhang.lyra at gmail.com:
> From: "zhizhou.zhang" <zhizhou.zhang@spreadtrum.com>
> 
> Adds build support for Spreadtrum's Shark64 SoC in arm64 dts Makefile.
> 
> Signed-off-by: zhizhou.zhang <zhizhou.zhang@spreadtrum.com>
> Signed-off-by: chunyan.zhang <chunyan.zhang@spreadtrum.com>
> ---
>  arch/arm64/boot/dts/Makefile |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
> index c52bdb0..7fdb9df 100644
> --- a/arch/arm64/boot/dts/Makefile
> +++ b/arch/arm64/boot/dts/Makefile
> @@ -1,5 +1,6 @@
>  dtb-$(CONFIG_ARCH_VEXPRESS) += rtsm_ve-aemv8a.dtb foundation-v8.dtb
>  dtb-$(CONFIG_ARCH_XGENE) += apm-mustang.dtb
> +dtb-$(CONFIG_ARCH_SHARK64) += sprd_shark64.dtb
>  
>  targets += dtbs
>  targets += $(dtb-y)

This patch seems so trivial that you could just squash it into 2/6
(adding the .dts file).

Also, it looks to me as if the ordering is alphabetical, so SHARK should
probably go somewhere before VEXPRESS, not after XGENE.

Regards,
Andreas

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg
