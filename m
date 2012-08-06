From: Dongjin.Kim@agreeyamobility.net (Dongjin Kim)
Date: Mon, 6 Aug 2012 18:16:18 +0000
Subject: =?utf-8?B?7ZqM7IugOiBbUEFUQ0hdIE9EUk9JRC1YOiBoa2RrNDQxMjogQWRkIG5ldyBo?=
 =?utf-8?Q?ardware_based_on_Exynos4412?=
In-Reply-To: <CAJuYYwSjnQ6z0iUaLCV9guC7yyKH3_pbd1QZe3ELKF-fYNfaqQ@mail.gmail.com>
References: <1344262254-14648-1-git-send-email-dongjin.kim@agreeyamobility.net>,
 <CAJuYYwSjnQ6z0iUaLCV9guC7yyKH3_pbd1QZe3ELKF-fYNfaqQ@mail.gmail.com>
Message-ID: <A6A3B7488C419F488E5B13FFD03C08AD2F4362EE@SN2PRD0510MB370.namprd05.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Tomas,

I am agree with you to look at using device tree and I have some plan for it.
But as of now I am focusing to bring up the hardware itself with mainline kernel and merge into it.
I also need some time to look at the requirement of device tree, because I am not familiar with it yet.

Any advice will be welcomed.

Thanks,
Dongjin.
________________________________________
?? ??: Thomas Abraham [thomas.abraham at linaro.org]
?? ??: 2012? 8? 7? ??? ?? 2:37
?? ??: Dongjin Kim
??: Dongjin Kim; Kukjin Kim; Russell King; Tony Lindgren; Jon Medhurst; Shawn Guo; Uwe Kleine-K?nig; linux-arm-kernel at lists.infradead.org; linux-samsung-soc at vger.kernel.org; linux-kernel at vger.kernel.org
??: Re: [PATCH] ODROID-X: hkdk4412: Add new hardware based on Exynos4412

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
