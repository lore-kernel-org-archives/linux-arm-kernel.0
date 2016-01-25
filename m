From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 25 Jan 2016 11:48:39 +0000
Subject: [PATCH] arm64: Fix typo mm/dump.c
In-Reply-To: <1453616652-8430-1-git-send-email-standby24x7@gmail.com>
References: <1453616652-8430-1-git-send-email-standby24x7@gmail.com>
Message-ID: <20160125114838.GA18877@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 24, 2016 at 03:24:12PM +0900, Masanari Iida wrote:
> This patch fix a typo in mm/dump.c
> "MODUELS_END_NR" should be "MODULES_END_NR".
> 
> Signed-off-by: Masanari Iida <standby24x7@gmail.com>

This looks sensible, though I believe that this is fixed implicitly as
part of Ard's kASLR patch series [1].

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-January/398535.html

> ---
>  arch/arm64/mm/dump.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/dump.c b/arch/arm64/mm/dump.c
> index 5a22a11..0adbebb 100644
> --- a/arch/arm64/mm/dump.c
> +++ b/arch/arm64/mm/dump.c
> @@ -46,7 +46,7 @@ enum address_markers_idx {
>  	PCI_START_NR,
>  	PCI_END_NR,
>  	MODULES_START_NR,
> -	MODUELS_END_NR,
> +	MODULES_END_NR,
>  	KERNEL_SPACE_NR,
>  };
>  
> -- 
> 2.7.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
