From: khilman@kernel.org (Kevin Hilman)
Date: Wed, 10 Dec 2014 08:17:26 -0800
Subject: [PATCH v4 0/3] Fix Arndale Octa/Peach Pi boot on Audio subsystem
 clocks
In-Reply-To: <1417777254-26579-1-git-send-email-k.kozlowski@samsung.com>
 (Krzysztof Kozlowski's message of "Fri, 05 Dec 2014 12:00:51 +0100")
References: <1417777254-26579-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <7h4mt3pjhl.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

Krzysztof Kozlowski <k.kozlowski@samsung.com> writes:

> Changes since v3
> ================
> 1. Patch 1/3: Fix issues pointed by Sylwester.
> 2. Add Javier's tested-by [1]

I tested this series on top of next-20141210 (exynos_defconfig and
multi_v7_defconfig) on exynos5800-peach-pi and exynos5420-arndale-octa
it fixes the boot hangs I was seeing with linux-next on those platforms.

Feel free to add:

Tested-by: Kevin Hilman <khilman@linaro.org>

Kevin
