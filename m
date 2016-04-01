From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 1 Apr 2016 17:09:19 +0530
Subject: [PATCH 1/2] phy: Group vendor specific phy drivers
In-Reply-To: <1459510156-9147-1-git-send-email-gautam.vivek@samsung.com>
References: <1459510156-9147-1-git-send-email-gautam.vivek@samsung.com>
Message-ID: <20160401113919.GC2987@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01-04-16, 16:59, Vivek Gautam wrote:
> Adding vendor specific directories in phy to group
> phy drivers under their respective vendor umbrella.
> 
> Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
> ---
>  drivers/phy/{ => st}/phy-spear1310-miphy.c        |   0
>  drivers/phy/{ => st}/phy-spear1340-miphy.c        |   0
>  rename drivers/phy/{ => st}/phy-spear1310-miphy.c (100%)
>  rename drivers/phy/{ => st}/phy-spear1340-miphy.c (100%)
> 

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
