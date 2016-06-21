From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 21 Jun 2016 13:16:45 +0200
Subject: [[PATCH v2] 04/11] ARM: EXYNOS: fixup endian in pm/pmu
In-Reply-To: <1466504432-24187-5-git-send-email-ben.dooks@codethink.co.uk>
References: <1466504432-24187-1-git-send-email-ben.dooks@codethink.co.uk>
 <1466504432-24187-5-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <5769221D.4060906@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/21/2016 12:20 PM, Ben Dooks wrote:
> Fix the PMU code endian access code to deal with kernels built for big endian
> operation.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  arch/arm/mach-exynos/common.h     | 4 ++--
>  arch/arm/mach-exynos/pm.c         | 4 ++--
>  arch/arm/mach-exynos/pm_domains.c | 6 +++---
>  3 files changed, 7 insertions(+), 7 deletions(-)


Thanks, applied for v4.8.

Best regards,
Krzysztof
