From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 06 Nov 2015 08:55:08 +0900
Subject: [PATCH v2 1/2] arm64: dts: exynos7: Add pmic s2mps15 device tree
 node
In-Reply-To: <1446724341-3568-1-git-send-email-alim.akhtar@samsung.com>
References: <1446724341-3568-1-git-send-email-alim.akhtar@samsung.com>
Message-ID: <563BEC5C.9040707@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05.11.2015 20:52, Alim Akhtar wrote:
> This patch add pmic (s2mps15) node of espresso board,
> which includes addition of regulators and pmic-clk sub-nodes.

My comment for fixing capital letters was ignored. Do you disagree with it?

> 
> This patch also adds {vmmc,vqmmc}-supply properties for mmc2 node.
> 
> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
> ---
> Changes since v1:
> * Addressed Javier and Krzysztof review comments.
> * Removed unused ldo/buck nodes.
> * Removed always-on properties from ldo/buck to disable them
> * Added a consumer of pmic supply (like mmc)
> 
>  arch/arm64/boot/dts/exynos/exynos7-espresso.dts |  280 +++++++++++++++++++++++
>  1 file changed, 280 insertions(+)
> 

Rest looks good, so with the fix above:

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
