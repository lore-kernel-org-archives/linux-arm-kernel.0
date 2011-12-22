From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 22 Dec 2011 17:50:28 +0000
Subject: [RFC PATCH v2 2/2] ARM: imx: Add mx5 cpuidle implmentation
In-Reply-To: <1323846126-7516-3-git-send-email-rob.lee@linaro.org>
References: <1323846126-7516-1-git-send-email-rob.lee@linaro.org>
 <1323846126-7516-3-git-send-email-rob.lee@linaro.org>
Message-ID: <20111222175027.GG29622@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 14, 2011 at 01:02:06AM -0600, Robert Lee wrote:

> +	clk_enable(&gpc_dvfs_clk);

Should these enables be in the cpuidle code?  The device appears to have
been working fine without them thus far...  Alternatively, if they
should be on anyway does this need to be split out and sent as a bug
fix?
