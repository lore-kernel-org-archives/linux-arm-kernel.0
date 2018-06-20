From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 20 Jun 2018 20:59:53 +0200
Subject: [PATCH] ARM: S3C24XX: fix typo in guard macro for s3c2412.h
In-Reply-To: <20180617194617.15145-1-efremov@linux.com>
References: <20180617194617.15145-1-efremov@linux.com>
Message-ID: <20180620185953.cty5esnbfhawnbau@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 17, 2018 at 10:46:17PM +0300, efremov at linux.com wrote:
> The guard macro __ARCH_ARM_REGS_S3C24XX_S3C2412_H in header s3c2412.h
> doesn't match the #ifndef macro __ARCH_ARM_MACH_S3C24XX_S3C2412_H.
> This patch defines the guard correctly.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Denis Efremov <efremov@linux.com>
> ---
>  arch/arm/mach-s3c24xx/include/mach/s3c2412.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Thanks, applied.

Best regards,
Krzysztof
