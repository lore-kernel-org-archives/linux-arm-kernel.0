From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 30 Jan 2017 21:43:29 +0200
Subject: [PATCH v3 1/7] soc: smasung: pmu: Add register defines for pad
 retention control
In-Reply-To: <1485779908-32147-2-git-send-email-m.szyprowski@samsung.com>
References: <1485779908-32147-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170130123837eucas1p1056a57f23b1e3bf089e5bc55bb2cf2d4@eucas1p1.samsung.com>
 <1485779908-32147-2-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20170130194329.duudcv5oxu2q2td4@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 30, 2017 at 01:38:22PM +0100, Marek Szyprowski wrote:
> Add PMU defines related to pad retention control. Will be later used
> by the Exynos pin controller driver.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  include/linux/soc/samsung/exynos-regs-pmu.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 

Thanks Marek.

Initially I thought that this should go through samsung-soc to limit
conflicts but I sent already my pull requests and I am not sure if I
will be getting more patches for next cycle. We'll see.

However, the point is, I do not want to block this patchset, so if
someone would like to take it before me, feel free:
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
