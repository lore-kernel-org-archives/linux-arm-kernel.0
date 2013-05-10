From: dianders@chromium.org (Doug Anderson)
Date: Fri, 10 May 2013 08:31:05 -0700
Subject: [PATCH] ARM: EXYNOS: Update defconfig for Arndale and Origen board
In-Reply-To: <1368168599-28507-1-git-send-email-tushar.behera@linaro.org>
References: <1368168599-28507-1-git-send-email-tushar.behera@linaro.org>
Message-ID: <CAD=FV=UUaZZj0=B7335pReyeQp3V2UvckH-jy-k4SqAop7C2gw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tushar,

On Thu, May 9, 2013 at 11:49 PM, Tushar Behera <tushar.behera@linaro.org> wrote:
> It updates following drivers for EXYNOS based DT platform.
>
> * S5M8767 driver
> * MAX8997 driver
> * MMC SDHCI driver
>
> Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
> ---
>
> This patch is based on Olof's following patch.
> "[PATCH] ARM: exynos: defconfig update"
> https://lkml.org/lkml/2013/5/9/455
>
>  arch/arm/configs/exynos_defconfig |    6 ++++++
>  1 file changed, 6 insertions(+)

Your changes also look good to me.

Reviewed-by: Doug Anderson <dianders@chromium.org>
