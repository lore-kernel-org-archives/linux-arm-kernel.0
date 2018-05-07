From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Mon, 7 May 2018 09:33:07 +0200
Subject: [PATCH] arm: Convert arm boot_lock to raw
In-Reply-To: <20180506182325.w7yvrpp3hcii54pj@kozik-lap>
References: <20180504105600.20613-1-bigeasy@linutronix.de>
 <20180506182325.w7yvrpp3hcii54pj@kozik-lap>
Message-ID: <20180507073307.uuumknm4fx3wbq3u@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-05-06 20:23:25 [+0200], Krzysztof Kozlowski wrote:
> >  arch/arm/mach-actions/platsmp.c   |    6 +++---
> >  arch/arm/mach-exynos/platsmp.c    |   12 ++++++------
> 
> I assume this is needed for -rt patches?
correct.

> For Exynos:
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> Tested on Exynos5422 (Odroid HC1) with Linaro PM-QA:
> Tested-by: Krzysztof Kozlowski <krzk@kernel.org>

thank you.

> Best regards,
> Krzysztof

Sebastian
