From: liu.h.jason@gmail.com (Jason Liu)
Date: Mon, 29 Aug 2011 15:33:10 +0800
Subject: [PATCH 0/2] Consolidate and clean up the arch/arm/mach-mx5/mm-*.c
In-Reply-To: <1314014005-9923-1-git-send-email-jason.hui@linaro.org>
References: <1314014005-9923-1-git-send-email-jason.hui@linaro.org>
Message-ID: <CAB4PhKcOJBs431iu3DD6c5p0YuAcQi49PysvdbW7HqJb94wHCQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Sascha,

2011/8/22 Jason Liu <jason.hui@linaro.org>:
> The two patches work for consolidate and clean up the arch/arm/mach-mx5/mm-*.c
>
> Jason Liu (2):
> ?ARM: i.MX5/mm: Consolidate arch/arm/mach-mx5/mm-*.c
> ?ARM: i.MX5/mm: use static mapping for TZIC
>
> ?arch/arm/mach-mx5/Makefile ? ? ? ? ? ?| ? ?1 -
> ?arch/arm/mach-mx5/mm-mx50.c ? ? ? ? ? | ? 72 ---------------------------------
> ?arch/arm/mach-mx5/mm.c ? ? ? ? ? ? ? ?| ? 61 +++++++++++++++++++++-------
> ?arch/arm/plat-mxc/include/mach/mx51.h | ? ?1 +
> ?arch/arm/plat-mxc/include/mach/mx53.h | ? ?1 +
> ?5 files changed, 48 insertions(+), 88 deletions(-)
> ?delete mode 100644 arch/arm/mach-mx5/mm-mx50.c

Any comments for this patch set?
The patch-set has the v2 version for :i.MX5/mm: use static mapping for
TZIC, which addresses
the comments from Uwe, the v2 is referenced here:
http://patchwork.ozlabs.org/patch/111075/



Thanks.

Jason
>
> --
> 1.7.4.1
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
