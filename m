From: khilman@linaro.org (Kevin Hilman)
Date: Wed, 16 Oct 2013 15:15:03 -0700
Subject: [PATCH v2 0/4] Exynos 5410 Dual cluster support
In-Reply-To: <1381763305-7085-1-git-send-email-v.tyrtov@samsung.com>
 (Vyacheslav Tyrtov's message of "Mon, 14 Oct 2013 19:08:21 +0400")
References: <1381763305-7085-1-git-send-email-v.tyrtov@samsung.com>
Message-ID: <87k3hc3lso.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vyacheslav Tyrtov <v.tyrtov@samsung.com> writes:

> The series of patches represent support of Exynos 5410 SoC
>     
> The Exynos 5410 is the first Samsung SoC based on bigLITTLE architecture.
> Patches allow all 8 CPU cores (4 x A7 and 4 x A15) to run at the same time
>     
> Patches add new platform description, support of clock controller,
> dual cluster support and device tree for Exynos 5410 
>    
> Has been build on v3.12-rc5.
> Has been tested on Exynos 5410 reference board (exynos_defconfig).

Has anyone tried this on the exynos5410 based odroid-xu yet?  

I tried booting this on my recently arrived odroid-xu, but am not
getting it to boot.

I'm not yet terribly familiar with this SoC, what are the settings 
needed for DEBUG_LL on this board?

Thanks,

Kevin
