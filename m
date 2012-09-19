From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 19 Sep 2012 15:25:23 -0600
Subject: [PATCH] ARM: dt: tegra: whistler: configure power off
In-Reply-To: <1347391237-31044-1-git-send-email-swarren@wwwdotorg.org>
References: <1347391237-31044-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <505A3843.4020301@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/11/2012 01:20 PM, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Add DT property to tell the MAX8907 that it should provide the
> pm_power_off() implementation. This allows "shutdown" to work.

I've applied this to Tegra's for-3.7/dt2 branch, which I hope to push to
arm-soc very shortly (i.e. tomorrow at latest); just waiting on
confirmation on Thierry's board .dts patches.
