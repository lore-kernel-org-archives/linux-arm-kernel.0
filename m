From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 13 Jul 2016 11:21:01 +0200
Subject: [PATCH v3 7/7] clk: exynos5433: remove CLK_IGNORE_UNUSED flag from
 SPI clocks
In-Reply-To: <146836184696.73491.9452469757415968654@resonance>
References: <1468317736-18841-1-git-send-email-andi.shyti@samsung.com>
 <1468317736-18841-8-git-send-email-andi.shyti@samsung.com>
 <146836184696.73491.9452469757415968654@resonance>
Message-ID: <578607FD.6050705@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/13/2016 12:17 AM, Michael Turquette wrote:
>
> Do you want these patches to go through same tree? If not, I can take
> this patch into clk-next.

I think this patch can safely go separately through the clk tree,
we just need to ensure whole series is merged for same release
to avoid regressions. There should be no problems with git bisect
since there is no exynos5433 based board dts in mainline yet.

--
Thanks,
Sylwester
