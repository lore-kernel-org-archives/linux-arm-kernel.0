From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 04 Apr 2013 19:56:40 +0900
Subject: [PATCH RESEND] ARM: SAMSUNG: dma: Remove unnecessary code
In-Reply-To: <1364902239-16704-1-git-send-email-padma.v@samsung.com>
References: <1364902239-16704-1-git-send-email-padma.v@samsung.com>
Message-ID: <515D5C68.3030906@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/02/13 20:30, Padmavathi Venna wrote:
> This patch removes the usage of DMACH_DT_PROP and dt_dmach_prop
> from dma code as the new generic dma dt binding support has been
> added.
>
> Signed-off-by: Padmavathi Venna<padma.v@samsung.com>
> Acked-by: Arnd Bergmann<arnd@arndb.de>
> ---
>   arch/arm/mach-s3c24xx/include/mach/dma.h       |    1 -
>   arch/arm/mach-s3c64xx/include/mach/dma.h       |    1 -
>   arch/arm/plat-samsung/dma-ops.c                |   10 +---------
>   arch/arm/plat-samsung/include/plat/dma-ops.h   |    1 -
>   arch/arm/plat-samsung/include/plat/dma-pl330.h |    1 -
>   5 files changed, 1 insertions(+), 13 deletions(-)
>

OK, applied.

Thanks.

- Kukjin
