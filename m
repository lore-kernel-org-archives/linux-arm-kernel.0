From: khilman@kernel.org (Kevin Hilman)
Date: Thu, 11 Jun 2015 14:46:07 -0700
Subject: [GIT PULL 5/5] Samsung mach updates for v4.2
In-Reply-To: <5571E4F7.40706@kernel.org> (Kukjin Kim's message of "Sat, 06 Jun
 2015 03:05:43 +0900")
References: <5571E4F7.40706@kernel.org>
Message-ID: <7hlhfpdilc.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kukjin Kim <kgene@kernel.org> writes:

> Hi,
>
> Here is Samsung mach updates for v4.2 and this is based on v4.1-rc4
> because of dependencies with previous Samsung fixes during -rc
>
> Please pull and if any problems, please let me know.
>
> Thanks,
> Kukjin
>
>
> The following changes since commit e26081808edadfd257c6c9d81014e3b25e9a6118:
>
>   Linux 4.1-rc4 (2015-05-18 10:13:47 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> tags/samsung-mach-1
>
> for you to fetch changes up to 2be2a3ff42a52e926cbd1cc1d376a161a9a73667:
>
>   ARM: EXYNOS: register power domain driver from core_initcall
> (2015-06-06 02:18:03 +0900)
>
> ----------------------------------------------------------------
> Samsung updates for v4.2
>
> - add failure(exception) handling
>   : of_iomap(), of_find_device_by_node() and kstrdup()
>
> - add common poweroff to use PS_HOLD based for all of exynos SoCs
> - add exnos_get/set_boot_addr() helper
> - constify platform_device_id and irq_domain_ops
> - get current parent clock for power domain on/off
> - use core_initcall to register power domain driver
> - make exynos_core_restart() less verbose
>
> - add support coupled CPUidle for exynos3250
>
> - fix exynos_boot_secondary() return value on timeout
> - fix clk_enable() in s3c24xx adc
> - fix missing of_node_put() for power domains
>
> ----------------------------------------------------------------

Pulled into next/soc,

Thanks,

Kevin
