From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 17 Mar 2016 13:19:33 +0700
Subject: [PATCH v2 all 01/14] arm: use of_platform_default_populate() to
 populate default bus
In-Reply-To: <1458113743-15131-2-git-send-email-wangkefeng.wang@huawei.com>
References: <1458113743-15131-1-git-send-email-wangkefeng.wang@huawei.com>
 <1458113743-15131-2-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <20160317061933.GB14898@vireshk-mac-ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16-03-16, 15:35, Kefeng Wang wrote:
> Use helper of_platform_default_populate() in linux/of_platform
> when possible, instead of calling of_platform_populate() with
> the default match table.
> 
> Acked-by: Shawn Guo <shawnguo@kernel.org>
> Acked-by: Heiko Stuebner <heiko@sntech.de>
> Acked-by: Krzysztof Halasa <khalasa@piap.pl>
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Ray Jui <rjui@broadcom.com>
> Cc: Lee Jones <lee@kernel.org>
> Cc: Krzysztof Halasa <khalasa@piap.pl>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Santosh Shilimkar <ssantosh@kernel.org>
> Cc: Roland Stigge <stigge@antcom.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Viresh Kumar <vireshk@kernel.org>
> Cc: Shiraz Hashim <shiraz.linux.kernel@gmail.com>
> Cc: Tony Prisk <linux@prisktech.co.nz>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Russell King <linux@arm.linux.org.uk>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  arch/arm/mach-spear/spear1310.c          | 2 +-
>  arch/arm/mach-spear/spear1340.c          | 2 +-
>  arch/arm/mach-spear/spear300.c           | 3 +--
>  arch/arm/mach-spear/spear310.c           | 3 +--
>  arch/arm/mach-spear/spear320.c           | 3 +--
>  arch/arm/mach-spear/spear6xx.c           | 3 +--

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
