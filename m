From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 1 Feb 2016 21:53:33 +0800
Subject: [PATCH v2 01/15] arm: use of_platform_default_populate() to
 populate default bus
In-Reply-To: <1453881180-12296-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1453868872-26300-2-git-send-email-wangkefeng.wang@huawei.com>
 <1453881180-12296-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <20160201135333.GI10671@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 27, 2016 at 03:53:00PM +0800, Kefeng Wang wrote:
> Use helper of_platform_default_populate() in linux/of_platform
> when possible, instead of calling of_platform_populate() with
> the default match table.
> 
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Ray Jui <rjui@broadcom.com>
> Cc: Lee Jones <lee@kernel.org>
> Cc: Krzysztof Halasa <khalasa@piap.pl>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
...
>  arch/arm/mach-imx/imx27-dt.c             | 2 +-
>  arch/arm/mach-imx/mach-imx51.c           | 2 +-
>  arch/arm/mach-imx/mach-imx53.c           | 2 +-
>  arch/arm/mach-imx/mach-imx6q.c           | 2 +-
>  arch/arm/mach-imx/mach-imx6sl.c          | 2 +-
>  arch/arm/mach-imx/mach-imx6sx.c          | 2 +-
>  arch/arm/mach-imx/mach-imx6ul.c          | 2 +-
>  arch/arm/mach-imx/mach-imx7d.c           | 2 +-
...
>  arch/arm/mach-mxs/mach-mxs.c             | 3 +--

Acked-by: Shawn Guo <shawnguo@kernel.org>
