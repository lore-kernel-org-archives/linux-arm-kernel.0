From: liu.h.jason@gmail.com (Jason Liu)
Date: Thu, 3 Nov 2011 09:31:05 +0800
Subject: [PATCH] ARM: mx25: Add the missing IIM base definition
In-Reply-To: <1320231836-9555-3-git-send-email-jason.hui@linaro.org>
References: <1320231836-9555-1-git-send-email-jason.hui@linaro.org>
	<1320231836-9555-3-git-send-email-jason.hui@linaro.org>
Message-ID: <CAB4PhKfuMZ+jmYk_QQ=WGXRreaaiGPKsjj4PPimR8kMH0Sxaaw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Sascha

2011/11/2 Jason Liu <jason.hui@linaro.org>:
> This fix the mx25 building issue of no IIM base definition
>
> Signed-off-by: Jason Liu <jason.hui@linaro.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> ---
> ?arch/arm/plat-mxc/include/mach/mx25.h | ? ?1 +
> ?1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/plat-mxc/include/mach/mx25.h b/arch/arm/plat-mxc/include/mach/mx25.h
> index 8dcab80..ccebf5b 100644
> --- a/arch/arm/plat-mxc/include/mach/mx25.h
> +++ b/arch/arm/plat-mxc/include/mach/mx25.h
> @@ -41,6 +41,7 @@
> ?#define MX25_SSI2_BASE_ADDR ? ? ? ? ? ?0x50014000
> ?#define MX25_SSI1_BASE_ADDR ? ? ? ? ? ?0x50034000
> ?#define MX25_NFC_BASE_ADDR ? ? ? ? ? ? 0xbb000000
> +#define MX25_IIM_BASE_ADDR ? ? ? ? ? ? 0x53ff0000
> ?#define MX25_DRYICE_BASE_ADDR ? ? ? ? ?0x53ffc000
> ?#define MX25_ESDHC1_BASE_ADDR ? ? ? ? ?0x53fb4000
> ?#define MX25_ESDHC2_BASE_ADDR ? ? ? ? ?0x53fb8000

Please ignore this patch, sorry for that.

Jason Liu
> --
> 1.7.4.1
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
