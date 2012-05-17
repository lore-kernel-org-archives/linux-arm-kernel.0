From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 17 May 2012 15:57:45 +0900
Subject: [PATCH 0/2] ARM: S3C64xx: cpuidle cleanups
In-Reply-To: <1337004377-17732-1-git-send-email-daniel.lezcano@linaro.org>
References: <1337004377-17732-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <0b2001cd33fa$5cd05490$1670fdb0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel Lezcano wrote:
> 
> These couple of patches use the new cpuidle core api to refactor
> some part of the code. The first one declares the states directly
> in the driver declaration and the second one use the timekeeping
> flag to let the cpuidle core to compute the idle time.
> 
Basically, looks ok to me.

> I don't have this board, I was not able to test these patches.
> 
Mark, could you please check this patches on your board?
Now, my smdk6410 has some problem to test this :(

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

> Daniel Lezcano (2):
>   ARM: s3c64xx: cpuidle - declare the states with the new api
>   ARM: s3c64xx: cpuidle - use timekeeping wrapper
> 
>  arch/arm/mach-s3c64xx/cpuidle.c |   45
+++++++++++++----------------------
> ----
>  1 files changed, 15 insertions(+), 30 deletions(-)
> 
> --
> 1.7.5.4
