From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 13 May 2016 08:28:48 +0530
Subject: [PATCH v4 03/18] arm: Remove unnecessary of_platform_populate
 with default match table
In-Reply-To: <1463054775-18170-4-git-send-email-wangkefeng.wang@huawei.com>
References: <1463054775-18170-1-git-send-email-wangkefeng.wang@huawei.com>
 <1463054775-18170-4-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <20160513025848.GK9661@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12-05-16, 20:06, Kefeng Wang wrote:
> After patch "of/platform: Add common method to populate default bus",
> it is possible for arch code to remove unnecessary callers about the
> of_platform_populate with default match table.
> 
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
>  arch/arm/mach-spear/spear1310.c         |  2 --
>  arch/arm/mach-spear/spear1340.c         |  1 -

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
