From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Wed, 18 Dec 2013 15:11:17 +0900
Subject: [PATCH 06/11] PM / devfreq: move definitions for exynos4_bus into
 drivers/devfreq
In-Reply-To: <116401cefb1e$75b83440$61289cc0$@kernel.org>
References: <116401cefb1e$75b83440$61289cc0$@kernel.org>
Message-ID: <CAJ0PZbTH0kga7Gbb87umJpCF_ih3TQrxKS0xBbofDvJq+_wj5Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 17, 2013 at 8:52 PM,  <kgene@kernel.org> wrote:
> From: Kukjin Kim <kgene.kim@samsung.com>
>
> We don't need to keep the definitions for exynos4_bus into
> mach-exynos/ so this moves them into drviers/devfreq with
> adding header file.

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>

However, how are you going to merge this patch?
Do you need me to get this handled or are you going to do it yourself
with Samsung-SoC tree?

Cheers,
MyungJoo.

>
> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
>  arch/arm/mach-exynos/include/mach/regs-clock.h |   94 --------------------
>  drivers/devfreq/exynos/exynos4_bus.c           |    4 +-
>  drivers/devfreq/exynos/exynos4_bus.h           |  110
> ++++++++++++++++++++++++
>  3 files changed, 112 insertions(+), 96 deletions(-)
>  create mode 100644 drivers/devfreq/exynos/exynos4_bus.h
>

-- 
MyungJoo Ham, Ph.D.
System S/W Lab, S/W Center, Samsung Electronics
