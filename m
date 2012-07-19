From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 19 Jul 2012 15:48:06 +0900
Subject: [PATCH] ARM: S3C64XX: Mark most Cragganmore initdata devinitdata
In-Reply-To: <1341245579-29007-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1341245579-29007-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <184601cd657a$73c1f940$5b45ebc0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> 
> With the greater use of deferred probes we need to be more sure that
> initdata is actually used only at system init rather than being used
> by devices when they probe (which could happen after the main kernel
> init has completed and is much more likely to now).
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  arch/arm/mach-s3c64xx/mach-crag6410.c |   68
++++++++++++++++-------------
> ----
>  1 file changed, 34 insertions(+), 34 deletions(-)
> 
[...]

Looks OK, applied.
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
