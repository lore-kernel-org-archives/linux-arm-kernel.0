From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 6 Aug 2012 23:07:33 +0530
Subject: [PATCH] ODROID-X: hkdk4412: Add new hardware based on Exynos4412
In-Reply-To: <1344262254-14648-1-git-send-email-dongjin.kim@agreeyamobility.net>
References: <1344262254-14648-1-git-send-email-dongjin.kim@agreeyamobility.net>
Message-ID: <CAJuYYwSjnQ6z0iUaLCV9guC7yyKH3_pbd1QZe3ELKF-fYNfaqQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 August 2012 19:40, Dongjin Kim <tobetter@gmail.com> wrote:
> The HKDK4412 is the CPU module developed by Hardkernel which is based on
> Exynos 4412.  mach_hkdk4412.c is to run on ODROID-X hardware and Machine ID
> (4289) is registered.
>
> Change-Id: I3af02808c03b9acea916c310390a4904ad92d761
> Signed-off-by: Dongjin Kim <dongjin.kim@agreeyamobility.net>
> ---
>  arch/arm/mach-exynos/Kconfig         |   23 +
>  arch/arm/mach-exynos/Makefile        |    1 +
>  arch/arm/mach-exynos/mach-hkdk4412.c |  979 ++++++++++++++++++++++++++++++++++
>  arch/arm/tools/mach-types            |    1 +
>  4 files changed, 1004 insertions(+)
>  create mode 100644 arch/arm/mach-exynos/mach-hkdk4412.c

How about looking at using device tree option for this board. That
might require additional effort but would be helpful in the long run.

Thanks,
Thomas.
