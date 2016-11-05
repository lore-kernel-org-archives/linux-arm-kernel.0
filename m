From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sat, 5 Nov 2016 17:41:19 +0200
Subject: [PATCH 1/4] ARM: EXYNOS: Remove smp_init_cpus hook from platsmp.c
In-Reply-To: <1478230764-13748-2-git-send-email-pankaj.dubey@samsung.com>
References: <1478230764-13748-1-git-send-email-pankaj.dubey@samsung.com>
 <1478230764-13748-2-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <20161105154119.GA8183@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 04, 2016 at 09:09:21AM +0530, Pankaj Dubey wrote:
> We can safely remove exynos_smp_init_cpus() hook from mach-exynos/platsmp.c,
> as all SMP platforms in mach-exynos can rely on DT for CPU core description
> instead of determining number of cores from the SCU.
> 
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
>  arch/arm/mach-exynos/platsmp.c | 31 -------------------------------
>  1 file changed, 31 deletions(-)
>


Thanks, applied. Somehow your patchset did not reach linux-samsung-soc's
Parchwork. I don't have a clue why... It is on linux-arm-kernel's
Patchwork.

Best regards,
Krzysztof
