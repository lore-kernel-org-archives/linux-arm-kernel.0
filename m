From: kmpark@infradead.org (Kyungmin Park)
Date: Mon, 7 Sep 2009 09:08:39 +0900
Subject: [PATCH 01/12] [ARM][S3C6410] keypad memory map support
In-Reply-To: <00a001ca2e2c$28b48b80$7a1da280$%yang@samsung.com>
References: <00a001ca2e2c$28b48b80$7a1da280$%yang@samsung.com>
Message-ID: <9c9fda240909061708m1cc96da0k4611a34c92596f67@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

First, where's keypad driver source codes?
Second, why how many patches are needed? I think only two patch, one
for keypad related, another is smdkc100 board specific.

Thank you,
Kyungmin Park


2009/9/5 ??? <jsgood.yang@samsung.com>:
> This patch introduces keypad memory map for new keypad driver.
> Also the new keypad driver will be provided to the mainline soon.
>
> Signed-off-by: Jinsung Yang <jsgood.yang@samsung.com>
> Signed-off-by: Kyeongil Kim <ki0351.kim@samsung.com>
> ---
> ?arch/arm/mach-s3c6400/include/mach/map.h | ? ?6 ++++++
> ?1 files changed, 6 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-s3c6400/include/mach/map.h b/arch/arm/mach-s3c6400/include/mach/map.h
> index 5057d99..d935570 100644
> --- a/arch/arm/mach-s3c6400/include/mach/map.h
> +++ b/arch/arm/mach-s3c6400/include/mach/map.h
> @@ -65,6 +65,10 @@
> ?#define S3C_VA_VIC0 ? ? ? ? ? ?(S3C_VA_IRQ + 0x00)
> ?#define S3C_VA_VIC1 ? ? ? ? ? ?(S3C_VA_IRQ + 0x10000)
>
> +/* keypad */
> +#define S3C64XX_PA_KEYPAD ? ? ?(0x7E00A000)
> +#define S3C64XX_SZ_KEYPAD ? ? ?SZ_4K
> +
> ?/* compatibiltiy defines. */
> ?#define S3C_PA_TIMER ? ? ? ? ? S3C64XX_PA_TIMER
> ?#define S3C_PA_HSMMC0 ? ? ? ? ?S3C64XX_PA_HSMMC0
> @@ -75,5 +79,7 @@
> ?#define S3C_PA_FB ? ? ? ? ? ? ?S3C64XX_PA_FB
> ?#define S3C_PA_USBHOST ? ? ? ? S3C64XX_PA_USBHOST
> ?#define S3C_PA_USB_HSOTG ? ? ? S3C64XX_PA_USB_HSOTG
> +#define S3C_PA_KEYPAD ? ? ? ? ?S3C64XX_PA_KEYPAD
> +#define S3C_SZ_KEYPAD ? ? ? ? ?S3C64XX_SZ_KEYPAD
>
> ?#endif /* __ASM_ARCH_6400_MAP_H */
> --
> 1.6.2.5
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
