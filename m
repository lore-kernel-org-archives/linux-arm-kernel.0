From: khilman@linaro.org (Kevin Hilman)
Date: Fri, 25 Apr 2014 15:56:55 -0700
Subject: [PATCH v8 0/3] Exynos 5410 support
In-Reply-To: <1397459860-21869-1-git-send-email-t.dakhran@samsung.com> (Tarek
 Dakhran's message of "Mon, 14 Apr 2014 11:17:37 +0400")
References: <1397459860-21869-1-git-send-email-t.dakhran@samsung.com>
Message-ID: <7hppk5f26g.fsf@paris.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tarek Dakhran <t.dakhran@samsung.com> writes:

> The series of patches represent support of Exynos 5410 SoC
>
> The Exynos 5410 is the first Samsung SoC based on bigLITTLE architecture
>
> Patches add new platform description, support of clock controller and device
> tree for Exynos 5410.
>
> Has been build on Linux Kernel v3.15-rc1
> Has been tested on: 1) Exynos 5410 reference board (exynos_defconfig)
> 		    2) Odroid-XU board (exynos_defconfig)

Tested-by: Kevin Hilman <khilman@linaro.org>

I also boot tested (to initramfs) on my odroid-XU and see the 4 "big"
cores booted.  Presumably I'm still missing the u-boot/firmware magic
for the little cores.

Kevin
