From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 8 Dec 2015 11:58:24 +0530
Subject: [PATCH v4 3/8] ARM: dts: Exynos5420: add CPU OPP properties
In-Reply-To: <1449512300-17230-4-git-send-email-b.zolnierkie@samsung.com>
References: <1449512300-17230-1-git-send-email-b.zolnierkie@samsung.com>
 <1449512300-17230-4-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <20151208062824.GV3294@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07-12-15, 19:18, Bartlomiej Zolnierkiewicz wrote:
> +	cpu1_opp_table: opp_table1 {
> +		compatible = "operating-points-v2";
> +		opp-shared;
> +		opp00 at 1300000000 {

This should be just opp at 1300000000, you don't need 00/01/02... anymore
now. Same for the other patch as well..

Fix that in other patches in this series and you also need to fix it
for arch/arm/boot/dts/exynos4212.dtsi based on what I see in
linux-next.

-- 
viresh
