From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 15 Nov 2011 18:14:22 +0900
Subject: [PATCH 2/2] MAINTAINERS: Extend Samsung patterns to cover SPI and
 ASoC drivers
In-Reply-To: <1320923776-26626-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1320923776-26626-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <1320923776-26626-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <005701cca376$f6abbba0$e40332e0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> 
> Help people find the overall architecture.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  MAINTAINERS |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a21d4fb..9eca526 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1054,6 +1054,8 @@ F:	arch/arm/plat-s3c24xx/
>  F:	arch/arm/plat-s5p/
>  F:	drivers/*/*s3c2410*
>  F:	drivers/*/*/*s3c2410*
> +F:	drivers/spi/spi-s3c*
> +F:	sound/soc/samsung/*
> 
>  ARM/S3C2410 ARM ARCHITECTURE
>  M:	Ben Dooks <ben-linux@fluff.org>
> --
> 1.7.7.2

Hmm, I'm ok on this but needs Grant's opinion :)

(Cc'ed Grant Likely)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
