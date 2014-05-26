From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Mon, 26 May 2014 12:19:54 +0530
Subject: [PATCH] arm: exynos: Fix "allmodconfig" build errors in mcpm and
 hotplug
In-Reply-To: <1401083696-25702-1-git-send-email-a.kesavan@samsung.com>
References: <1401083696-25702-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <CAK9yfHzNkVZX6pMkFmdeubTgoZdRhd=U0oMtUDHr9bvZZYQYbQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Abhilash.

On 26 May 2014 11:24, Abhilash Kesavan <a.kesavan@samsung.com> wrote:
> This fixes the following build errors:
>
> /tmp/ccRbZlaA.s: Assembler messages:
> /tmp/ccRbZlaA.s:69: Error: selected processor does not support ARM mode `isb '
> /tmp/ccRbZlaA.s:75: Error: selected processor does not support ARM mode `isb '
> /tmp/ccRbZlaA.s:76: Error: selected processor does not support ARM mode `dsb '
> make[1]: *** [arch/arm/mach-exynos/hotplug.o] Error 1
>
> /tmp/ccJEg4jw.s: Assembler messages:
> /tmp/ccJEg4jw.s:454: Error: selected processor does not support ARM mode `isb'
> /tmp/ccJEg4jw.s:455: Error: selected processor does not support ARM mode `dsb'
> /tmp/ccJEg4jw.s:465: Error: selected processor does not support ARM mode `isb'
> /tmp/ccJEg4jw.s:474: Error: selected processor does not support ARM mode `isb'
> /tmp/ccJEg4jw.s:475: Error: selected processor does not support ARM mode `dsb'
> /tmp/ccJEg4jw.s:516: Error: selected processor does not support ARM mode `isb'
> /tmp/ccJEg4jw.s:525: Error: selected processor does not support ARM mode `isb'
> /tmp/ccJEg4jw.s:526: Error: selected processor does not support ARM mode `dsb'
> make[1]: *** [arch/arm/mach-exynos/mcpm-exynos.o] Error 1
>
> Reported-by: Sachin Kamat <sachin.kamat@linaro.org>
> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>

This patch fixes the above reported issues.

Tested-by: Sachin Kamat <sachin.kamat@linaro.org>

-- 
With warm regards,
Sachin
