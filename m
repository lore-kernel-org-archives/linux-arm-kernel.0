From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 20 Sep 2014 04:52:31 +0200
Subject: [PATCH] MAINTAINERS: update ARM pxa maintainers
In-Reply-To: <87tx43xswd.fsf@free.fr>
References: <1409342875-31720-1-git-send-email-robert.jarzmik@free.fr>
 <87tx43xswd.fsf@free.fr>
Message-ID: <201409200452.31999.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 19 September 2014, Robert Jarzmik wrote:
> Hi Arnd,
> 
> I think I met the necessary number of acks. I amended the patch to reflect this,
> attached to this mail.

I disagree. For any other patch I'd be fine with this, but changing
maintainership is a delicate issue, and I don't want to remove Russell
from the list without having seen a comment from him with either
Ack or Nak.

> > Could you schedule this single patch for your maintainers branch (or for-next by
> default) in arm-soc please ?

Let's give Russell a few more days to comment, if we don't here anything from him,
I'd suggest to leave him listed as maintainer and just do the other changes.
You can reorder the list in any way you see fit.

	Arnd

> From c4d1e8e185c76654452c5161c86f3cc34b3ba103 Mon Sep 17 00:00:00 2001
> From: Robert Jarzmik <robert.jarzmik@free.fr>
> Date: Fri, 29 Aug 2014 22:07:55 +0200
> Subject: [PATCH] MAINTAINERS: update ARM pxa maintainers
> 
> Change pxa active maintainers, and remove more busy people.
> Remove Eric's tree as it is not accessible anymore.
> 
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> Acked-by: Daniel Mack <zonque@gmail.com>
> Acked-by: Eric Miao <eric.y.miao@gmail.com>
> Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>
> ---
>  MAINTAINERS | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1ff06de..d7ec0f6 100644
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
