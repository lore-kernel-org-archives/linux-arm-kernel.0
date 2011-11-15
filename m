From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 15 Nov 2011 16:21:36 +0900
Subject: [PATCH 1/2] MAINTAINERS: Add linux-samsung-soc mailing list for
 Samsung
In-Reply-To: <1320923776-26626-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1320923776-26626-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <003801cca367$360b7020$a2225060$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> 
> There's a Samsung-specific mailing list but it's not advertised in
> MAINTAINERS - add it to the overall architecture to make it more
> discoverable.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

I'm okay on this,
Acked-by: Kukjin Kim <kgene.kim@samsung.com>

(Cc'ed Andrew Morton)
Hi Andrew, could you please pick this up in your tree?

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

> ---
>  MAINTAINERS |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c18b278..a21d4fb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1046,6 +1046,7 @@ ARM/SAMSUNG ARM ARCHITECTURES
>  M:	Ben Dooks <ben-linux@fluff.org>
>  M:	Kukjin Kim <kgene.kim@samsung.com>
>  L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
> +L:	linux-samsung-soc at vger.kernel.org
>  W:	http://www.fluff.org/ben/linux/
>  S:	Maintained
>  F:	arch/arm/plat-samsung/
> --
> 1.7.7.2
