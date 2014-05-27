From: khilman@linaro.org (Kevin Hilman)
Date: Tue, 27 May 2014 10:06:56 -0700
Subject: [PATCH v11 0/3] Exynos 5410 support
In-Reply-To: <1401074613-29227-1-git-send-email-t.dakhran@samsung.com> (Tarek
 Dakhran's message of "Mon, 26 May 2014 07:23:30 +0400")
References: <1401074613-29227-1-git-send-email-t.dakhran@samsung.com>
Message-ID: <7hr43f9mmn.fsf@paris.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tarek Dakhran <t.dakhran@samsung.com> writes:

> The series of patches represent support of Exynos 5410 SoC
>
> The Exynos 5410 is the first Samsung SoC based on big.LITTLE architecture
>
> Patches add new platform description, support of clock controller and device
> tree for Exynos 5410.
>
> Has been build on Samsung Linux Kernel
>   (branch: for-next, commit: 97eae6c Merge branch 'v3.16-next/multiplatform' into for-next)
>
> Has been tested on: 1) Exynos 5410 reference board (exynos_defconfig)
> 		    2) Exynos 5410 reference board (multi_v7_defconfig)
> 		    3) Odroid-XU board (exynos_defconfig)
> 		    4) Odroid-XU board (multi_v7_defconfig)

Tested-by: Kevin Hilman <khilman@linaro.org>

FYI, I boot tested this on an odroid-xu (exynos_defconfig and
multi_v7_defconfig.)

Kevin
