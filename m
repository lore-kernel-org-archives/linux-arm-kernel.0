From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 16 Sep 2016 16:31:32 +0200
Subject: [GIT PULL] ARM: exynos: Fixes for v4.8, secound round
In-Reply-To: <1474009808-8520-1-git-send-email-k.kozlowski@samsung.com>
References: <CGME20160916071017eucas1p155978eec97e20211d9c54ef670e319eb@eucas1p1.samsung.com>
 <1474009808-8520-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <6792013.IrD9SrjCDf@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, September 16, 2016 9:10:08 AM CEST Krzysztof Kozlowski wrote:
> 1. A recent change in populating irqchip devices from Device Tree
>    broke Suspend to RAM on Exynos boards due to lack of probing of
>    PMU (Power Management Unit) driver.  Multiple drivers attach to
>    the PMU's DT node: irqchip, clock controller and PMU platform
>    driver for handling suspend.  The new irqchip code marked the
>    PMU's DT node as OF_POPULATED but we need to attach to this
>    node also PMU platform driver.
> 
> 2. Add Javier as additional reviewer for Exynos patches.
> 

Pulled into fixes, thanks!

	Arnd
