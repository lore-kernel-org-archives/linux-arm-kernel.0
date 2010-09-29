From: kmpark@infradead.org (Kyungmin Park)
Date: Thu, 30 Sep 2010 08:58:10 +0900
Subject: [PATCH 1/3] ARM: L2X0: Add prefetch offset
In-Reply-To: <20100911053052.GA23200@july>
References: <20100911053052.GA23200@july>
Message-ID: <AANLkTiky_7y9x7DcU+0W=e33DSH=GhDM3_R2DrqT23UF@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

Any comments?

On Sat, Sep 11, 2010 at 2:30 PM, Kyungmin Park <kmpark@infradead.org> wrote:
> From: Kyungmin Park <kyungmin.park@samsung.com>
>
> PL310 has prefetch offset as 0xF60
>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
> ?arch/arm/include/asm/hardware/cache-l2x0.h | ? ?1 +
> ?1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/include/asm/hardware/cache-l2x0.h b/arch/arm/include/asm/hardware/cache-l2x0.h
> index 6bcba48..cc9bcbb 100644
> --- a/arch/arm/include/asm/hardware/cache-l2x0.h
> +++ b/arch/arm/include/asm/hardware/cache-l2x0.h
> @@ -53,6 +53,7 @@
> ?#define L2X0_LINE_DATA ? ? ? ? ? ? ? ? 0xF10
> ?#define L2X0_LINE_TAG ? ? ? ? ? ? ? ? ?0xF30
> ?#define L2X0_DEBUG_CTRL ? ? ? ? ? ? ? ? ? ? ? ?0xF40
> +#define L2X0_PREFETCH_CTRL ? ? ? ? ? ? 0xF60
>
> ?#ifndef __ASSEMBLY__
> ?extern void __init l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask);
> --
> 1.5.3.3
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
