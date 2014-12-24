From: p.pisati@gmail.com (Paolo Pisati)
Date: Wed, 24 Dec 2014 17:36:26 +0100
Subject: [PATCH] clk: samsung: Fix Exynos 5420 pinctrl setup and clock
 disable failure due to domain being gated
In-Reply-To: <7hlhmfo1b0.fsf@deeprootsystems.com>
References: <1417788934-23447-1-git-send-email-k.kozlowski@samsung.com>
 <1418129982.19339.6.camel@AMDC1943> <5486F69B.6020005@samsung.com>
 <7hlhmfo1b0.fsf@deeprootsystems.com>
Message-ID: <20141224163626.GA3902@peachpi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 10, 2014 at 09:35:31AM -0800, Kevin Hilman wrote:
> 
> I confirm it fixes the boot hang in linux-next (next-20141210) on my
> exynos5800-peach-pi and exynos5420-arndale-octa.  Tested both
> exynos_defconfig and multi_v7_defconfig.
> 
> Tested-by: Kevin Hilman <khilman@linaro.org>

does audio work on your peach pi? because kernel boots fine, but i can't get any
audio out of it

-- 
bye,
p.
