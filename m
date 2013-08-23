From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 23 Aug 2013 10:24:39 -0600
Subject: [PATCH] cpufreq: tegra: fix the wrong clock name
In-Reply-To: <1377222238-9439-1-git-send-email-josephl@nvidia.com>
References: <1377222238-9439-1-git-send-email-josephl@nvidia.com>
Message-ID: <52178CC7.2070003@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/22/2013 07:43 PM, Joseph Lo wrote:
> The "cpu" and "pclk_p_cclk" was a virtual clock name that was used in
> the legacy Tegra clock framework. It was not used after converting to
> CCF. Fix it as the correct clock name that we are using.

Tested-by: Stephen Warren <swarren@nvidia.com>
