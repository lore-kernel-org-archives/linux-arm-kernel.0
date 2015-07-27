From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Mon, 27 Jul 2015 16:27:08 +0200
Subject: [PATCH V2 07/11] OPP: Add clock-latency-ns support
In-Reply-To: <7598a88f9de8d8dbd96de40b4ecdf30f68cfca8a.1437972635.git.viresh.kumar@linaro.org>
References: <cover.1437972635.git.viresh.kumar@linaro.org>
 <7598a88f9de8d8dbd96de40b4ecdf30f68cfca8a.1437972635.git.viresh.kumar@linaro.org>
Message-ID: <1509464.37oR9zhrb7@amdc1976>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

On Monday, July 27, 2015 10:32:37 AM Viresh Kumar wrote:
> With "operating-points-v2" bindings, clock-latency is defined per OPP.
> Users of this value expect a single value which defines the latency to
> switch to any clock rate. Find maximum clock-latency-ns from the OPP
> table to service requests from such users.
> 
> Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
