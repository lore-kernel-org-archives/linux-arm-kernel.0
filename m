From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Tue, 2 Sep 2014 11:08:02 +0800
Subject: [PATCH] MAINTAINERS: update ARM pxa maintainers
In-Reply-To: <1409342875-31720-1-git-send-email-robert.jarzmik@free.fr>
References: <1409342875-31720-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <CAN1soZxxdEb6UVH4J8skc_PPgmY2KCY=LBj3Hp0R9rRxtZoGgA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 30, 2014 at 4:07 AM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> Change pxa active maintainers, and remove more busy people.
> Remove Eric's tree as it is not accessible anymore.
>
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---
>  MAINTAINERS | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 217dc54..76ee718 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7291,12 +7291,12 @@ F:      drivers/video/backlight/pwm_bl.c
>  F:     include/linux/pwm_backlight.h
>
>  PXA2xx/PXA3xx SUPPORT
> -M:     Eric Miao <eric.y.miao@gmail.com>
> -M:     Russell King <linux@arm.linux.org.uk>
>  M:     Haojian Zhuang <haojian.zhuang@gmail.com>
> +M:     Robert Jarzmik <robert.jarzmik@free.fr>
> +M:     Daniel Mack <daniel@zonque.org>
>  L:     linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
>  T:     git git://github.com/hzhuang1/linux.git
> -T:     git git://git.linaro.org/people/ycmiao/pxa-linux.git
> +T:     git git://github.com/rjarzmik/linux.git
>  S:     Maintained
>  F:     arch/arm/mach-pxa/
>  F:     drivers/pcmcia/pxa2xx*
> --
> 2.0.0.rc2
>

Acked

Regards
Haojian
