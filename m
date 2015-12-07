From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 7 Dec 2015 15:37:00 +0530
Subject: [PATCH 2/2] ARM64: dts: mt8173: Add CPU OPP, clock and regulator
 supply properties
In-Reply-To: <1449305584-414-3-git-send-email-pi-cheng.chen@linaro.org>
References: <1449305584-414-1-git-send-email-pi-cheng.chen@linaro.org>
 <1449305584-414-3-git-send-email-pi-cheng.chen@linaro.org>
Message-ID: <20151207100700.GH3294@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05-12-15, 16:53, Pi-Cheng Chen wrote:
> +	cluster0_opp: opp_table0 {
> +		compatible = "operating-points-v2";
> +		opp-shared;
> +		opp00 {

These have to named like: opp at 50700000, look at linux-next for this.

-- 
viresh
