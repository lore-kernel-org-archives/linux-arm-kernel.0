From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 18 Apr 2016 14:30:23 +0200
Subject: [RESPIN v2 0/6] Add support for Exynos SROM Controller driver
In-Reply-To: <1460360548-32127-1-git-send-email-pankaj.dubey@samsung.com>
References: <1460360548-32127-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <5714D35F.1070705@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/11/2016 09:42 AM, Pankaj Dubey wrote:
> This is second attemp for making in this series. This is a collection of patches
> already reviewed and merged in maintainer's tree, but could not make it thorugh main linus tree,
> due to last moment suggestion of proper location of driver should be
> "drivers/memory" instead of "drivers/soc". I have rebased all the patches
> and moved into "drivers/memory/samsung". Second time due to some suggestions in binding document.
> 
> As this is just a movement without changing actual driver code,
> I have not removed "Reviewed-By", "Tested-By" or "Acked-By".
> 
> To make sure everything is fine, I have again tested it on Exynos5880 based
> Chromebook for normal boot, S2R functionality and its working fine.
> 
> This series has been prepared on top of next-soc branch of Krzysztof's tree.
> 
> Changes since RESPIN-v1:
>  - Addressed review comments in srom binding documentation mainly from Rob Herring.
>  - Modified compatibility from "samsung, exynos-srom" to "samsung, exynos4210-srom"
>  - Changed type of optional property "samsung,srom-page-mode" from int to bool
>  - Adjusted exynos-srom driver code for reflecting change in type of above property.
>  - Renamed exynos SROM dt node as "memory-controller" instead of "sromc".
> 
> 
> Pankaj Dubey (5):
>   dt-bindings: EXYNOS: Add exynos-srom device tree binding
>   memory: Add support for Exynos SROM driver
>   MAINTAINERS: Add maintainers entry for drivers/memory/samsung
>   ARM: EXYNOS: Remove SROM related register settings from mach-exynos
>   ARM: dts: change SROM node compatible from generic to model specific
> 
> Pavel Fedin (1):
>   memory: samsung: exynos-srom: Add support for bank configuration

Thanks applied. I plan to send it for v4.7 in second pull-request.

Best regards,
Krzysztof
