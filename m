From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 11 Dec 2015 10:34:13 +0900
Subject: [PATCH v5 0/7] cpufreq: add generic cpufreq driver support for
 Exynos542x/5800 platforms
In-Reply-To: <1449766729-435-1-git-send-email-b.zolnierkie@samsung.com>
References: <1449766729-435-1-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <566A2815.2020908@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11.12.2015 01:58, Bartlomiej Zolnierkiewicz wrote:
> Hi,
> 
> This patch series adds generic cpufreq-dt driver support for
> Exynos542x/5800 (using the new CPU clock type which allows it).
> 
> It has been tested on Exynos5422 based ODROID-XU3 Lite board.
> 
> Depends on:
> - next-20151124 branch of linux-next kernel tree

Bartlomiej,
Thanks for update! Nice work. Everything looks good for me. As for
merging, my last pull requests are waiting on Kukjin, so I am not
grabbing more stuff till they get in. This (I hope) should happen this
weekend so:
1. Either Kukjin will pick it up directly,
2. I could apply this later and hopefully still send them for v4.5.


Sylwester,
However in case of any delay, how about merging clock changes now
through clock tree and preparing a tag for samsung-soc? If the series
won't make till v4.5 then at least dependency would be merged.

In that case you could also pick the first patch from Marek's GSCL clock.


Best regards,
Krzysztof
