From: vz@mleia.com (Vladimir Zapolskiy)
Date: Mon, 11 Jun 2018 17:40:02 +0300
Subject: [PATCH v6 4/5] clocksource: add driver for i.MX EPIT timer
In-Reply-To: <20180607140544.22268-5-peron.clem@gmail.com>
References: <20180607140544.22268-1-peron.clem@gmail.com>
 <20180607140544.22268-5-peron.clem@gmail.com>
Message-ID: <27c914a5-22b2-1f64-dc89-4ecee5bff2b9@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/07/2018 05:05 PM, Cl?ment P?ron wrote:
> From: Colin Didier <colin.didier@devialet.com>
> 
> Add driver for NXP's EPIT timer used in i.MX SoC.
> 
> Signed-off-by: Colin Didier <colin.didier@devialet.com>
> Signed-off-by: Cl?ment Peron <clement.peron@devialet.com>

Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>
Tested-by: Vladimir Zapolskiy <vz@mleia.com>

I tested the driver on i.MX31 only, and I didn't find any problems.

Please fix the indentation issue found by Stefan in v7.

Regarding utilization of timer-of.c it can be postponed IMHO,
but it's up to clocksource maintainers and you to decide, and if
you do such an update for v7, then please don't add my tags,
I'll review and test it again.

--
With best wishes,
Vladimir
