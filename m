From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 14 May 2010 18:06:39 +0900
Subject: [PATCH v2] ARM: S5P: Add System Timer
In-Reply-To: <1273827090-26635-1-git-send-email-kgene.kim@samsung.com>
References: <1273827090-26635-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <00b901caf344$c6525290$52f6f7b0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kukjin Kim wrote:
> 
> From: Jongpill Lee <boyko@samsung.com>

Jongpill Lee's e-mail was wrong.
boyko.lee at samsung.com is right.

> 
> This patch addes system timer for Samsung S5P series SoCs

Regarding using clksrc_src structure in system timer driver, is it ok if we
sent separate patch for this.

> Signed-off-by: Jongpill Lee <boyko.lee@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
>  arch/arm/mach-s5p6442/include/mach/tick.h      |    6 +
>  arch/arm/mach-s5p6442/mach-smdk6442.c          |    2 +-
>  arch/arm/mach-s5pv210/include/mach/tick.h      |    6 +
>  arch/arm/mach-s5pv210/mach-smdkc110.c          |    2 +-
>  arch/arm/mach-s5pv210/mach-smdkv210.c          |    2 +-
>  arch/arm/plat-s5p/Kconfig                      |    7 +
>  arch/arm/plat-s5p/Makefile                     |    1 +
>  arch/arm/plat-s5p/include/plat/regs-systimer.h |   75 ++++++
>  arch/arm/plat-s5p/s5p-systimer.c               |  287
> ++++++++++++++++++++++++
>  arch/arm/plat-samsung/include/plat/cpu.h       |    3 +
>  10 files changed, 388 insertions(+), 3 deletions(-)
>  create mode 100644 arch/arm/plat-s5p/include/plat/regs-systimer.h
>  create mode 100644 arch/arm/plat-s5p/s5p-systimer.c
> 

(snip)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
