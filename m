From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 13 May 2016 08:29:18 +0530
Subject: [PATCH v4 12/18] arm: use of_platform_default_populate() to
 populate
In-Reply-To: <1463054775-18170-13-git-send-email-wangkefeng.wang@huawei.com>
References: <1463054775-18170-1-git-send-email-wangkefeng.wang@huawei.com>
 <1463054775-18170-13-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <20160513025918.GL9661@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12-05-16, 20:06, Kefeng Wang wrote:
> Use helper of_platform_default_populate() in linux/of_platform
> when possible, instead of calling of_platform_populate() with
> the default match table.
> 
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Krzysztof Halasa <khalasa@piap.pl>
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Roland Stigge <stigge@antcom.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Ray Jui <rjui@broadcom.com>
> Cc: Viresh Kumar <vireshk@kernel.org>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  arch/arm/mach-spear/spear300.c           | 3 +--
>  arch/arm/mach-spear/spear310.c           | 3 +--
>  arch/arm/mach-spear/spear320.c           | 3 +--
>  arch/arm/mach-spear/spear6xx.c           | 3 +--

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
