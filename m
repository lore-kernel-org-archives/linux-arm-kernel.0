From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sun, 18 Nov 2018 15:13:30 +0100
Subject: [PATCH 1/9] ARM: EXYNOS: remove secondary startup initialization
 from smp_prepare_cpus
In-Reply-To: <1542294698-17470-2-git-send-email-b.zolnierkie@samsung.com>
References: <1542294698-17470-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20181115151211epcas2p4fdc719d354f2a732f70667ccbd8f1bae@epcas2p4.samsung.com>
 <1542294698-17470-2-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <20181118141330.GA28873@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 15, 2018 at 04:11:30PM +0100, Bartlomiej Zolnierkiewicz wrote:
> From: Pankaj Dubey <pankaj.dubey@samsung.com>
> 
> We are taking care of setting secondary cpu boot address in
> exynos_boot_secondary just before sending ipi to secondary CPUs,
> so we can safely remove this setting from smp_prepare_cpus.
> 
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  arch/arm/mach-exynos/platsmp.c | 26 --------------------------

Thanks, applied.

Best regards,
Krzysztof
