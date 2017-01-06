From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 6 Jan 2017 16:03:33 +0200
Subject: [PATCH v5 5/5] arm64: dts: exynos: Add tm2 touchkey node
In-Reply-To: <20170106134350.32428-6-andi.shyti@samsung.com>
References: <20170106134350.32428-1-andi.shyti@samsung.com>
 <CGME20170106134356epcas1p1aee9f715c58b50f6056bf0b43b849497@epcas1p1.samsung.com>
 <20170106134350.32428-6-andi.shyti@samsung.com>
Message-ID: <20170106140333.v47qqspgvmkd24zg@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 06, 2017 at 10:43:50PM +0900, Andi Shyti wrote:
> From: Jaechul Lee <jcsing.lee@samsung.com>
> 
> Add DT node support for TM2 touchkey device.
> 
> Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
> Signed-off-by: Jaechul Lee <jcsing.lee@samsung.com>
> Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
> ---
>  arch/arm64/boot/dts/exynos/exynos5433-tm2.dts | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 

Looks good, but I will wait with this one till the bindings and driver
got accepted.

Best regards,
Krzysztof
