From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 23 Mar 2017 21:15:01 +0200
Subject: [PATCH v4 2/6] pinctrl: samsung: Add support for pad retention
 control for Exynos5433 SoCs
In-Reply-To: <1490256207-10061-3-git-send-email-m.szyprowski@samsung.com>
References: <1490256207-10061-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170323080348eucas1p188a598869b71a1302160df46839b3ca8@eucas1p1.samsung.com>
 <1490256207-10061-3-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20170323191501.3xufnbb5nqhm4szm@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 23, 2017 at 09:03:23AM +0100, Marek Szyprowski wrote:
> This patch adds support for retention control for Exynos5433 SoCs. Three
> groups of pins has been defined for retention control: common shared group
> for ALIVE, CPIF, eSE, FINGER, IMEM, NFC, PERIC, TOUCH pin banks and
> separate control for FSYS and AUD pin banks, for which PMU retention
> registers match whole banks.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/pinctrl/samsung/pinctrl-exynos.c | 58 ++++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
> 

Thanks, applied.

Let it settle for one day so auto-builders will catch up and then I will
provide a stable tag for Lee (MFD).

Best regards,
Krzysztof
