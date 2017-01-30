From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Mon, 30 Jan 2017 14:43:01 +0530
Subject: [PATCH 0/4] phy/mfd/soc: exynos: Header cleanup
In-Reply-To: <20170127200510.4444-1-krzk@kernel.org>
References: <20170127200510.4444-1-krzk@kernel.org>
Message-ID: <588F039D.3090503@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Saturday 28 January 2017 01:35 AM, Krzysztof Kozlowski wrote:
> Hi,
> 
> Suggested by Marek, continuation of cleanup of PMU register defines
> in headers.
> 
> Let's keep all of them in include/linux/soc/samsung/exynos-regs-pmu.h.
> 
> This is based on:
> 1. Marek's recent work around pinctrl/power domains/lpass:
>    https://git.linaro.org/people/marek.szyprowski/linux-srpol.git
>    branch: v4.10-next-tm2-pd
> 
> 2. My two previous patches for cleanup:
>    https://git.kernel.org/cgit/linux/kernel/git/krzk/linux.git
>    branch: for-v4.11/drivers-soc-exynos-pmu-the-joy-never-ends
> 
> Affected subsystems/drivers:
> 1. phy - drivers,
> 2. mfd - headers,
> 3. soc/samsung - header.
> 
> However because of dependency on Marek's patchset, I do not have a clue
> how to merge it... it is not an urgent stuff, so it may wait till
> dependencies get in.

I'll defer merging this.

Thanks
Kishon
