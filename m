From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 22 Jul 2013 14:14:40 +0200
Subject: [PATCH] clk: exynos4: Add CLK_GET_RATE_NOCACHE flag for the
 Exynos4x12 ISP clocks
In-Reply-To: <1372099374-21008-1-git-send-email-s.nawrocki@samsung.com>
References: <1372099374-21008-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <51ED2230.8080100@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/24/2013 08:42 PM, Sylwester Nawrocki wrote:
> The ISP clock registers belong to the ISP power domain and may change
> their values if this power domain is switched off/on. Add
> CLK_GET_RATE_NOCACHE flags to ensure we do not rely on invalid cached
> data when setting or getting frequency of those clocks.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

Mike,

would you consider queueing that patch for current -rc cycle ?

Thanks,
Sylwester
