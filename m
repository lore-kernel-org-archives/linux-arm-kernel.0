From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 16 Sep 2013 10:36:19 -0600
Subject: [PATCH 3/3] arm: dts: socfpga: Add support for SD/MMC
In-Reply-To: <1963011.uUY4o6LRbA@flatron>
References: <1378740833-4883-1-git-send-email-dinguyen@altera.com>
 <1378740833-4883-4-git-send-email-dinguyen@altera.com>
 <522E398F.3080100@wwwdotorg.org> <1963011.uUY4o6LRbA@flatron>
Message-ID: <52373383.7030601@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/14/2013 06:30 AM, Tomasz Figa wrote:
...
> Just as a side note, correct name is Synopsys, not Synopsis. There are
> multiple places around Documentation/devicetree where this typo is
> present[1]. Should we consider correcting this or the typo will have
> to stay?
> 
> [1] git grep -i synopsis Documentation/devicetree/
> Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt:* Samsung Exynos specific extensions to the Synopsis Designware Mobile
> Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt:The Synopsis designware mobile storage host controller is used to interface
> Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt:differences between the core Synopsis dw mshc controller properties described
> Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt:by synopsis-dw-mshc.txt and the properties used by the Samsung Exynos specific
> Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt:extensions to the Synopsis Designware Mobile Storage Host Controller.
> Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt:* Rockchip specific extensions to the Synopsis Designware Mobile
> Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt:The Synopsis designware mobile storage host controller is used to interface
> Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt:differences between the core Synopsis dw mshc controller properties described
> Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt:by synopsis-dw-mshc.txt and the properties used by the Rockchip specific
> Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt:extensions to the Synopsis Designware Mobile Storage Host Controller.
> Documentation/devicetree/bindings/mmc/synopsis-dw-mshc.txt:* Synopsis Designware Mobile Storage Host Controller
> Documentation/devicetree/bindings/mmc/synopsis-dw-mshc.txt:The Synopsis designware mobile storage host controller is used to interface
> Documentation/devicetree/bindings/mmc/synopsis-dw-mshc.txt:properties used by the Synopsis Designware Mobile Storage Host Controller.
> Documentation/devicetree/bindings/mmc/synopsis-dw-mshc.txt:     - snps,dw-mshc: for controllers compliant with synopsis dw-mshc.
> Documentation/devicetree/bindings/pci/designware-pcie.txt:* Synopsis Designware PCIe interface

Those typos only appear to exist in free-form text and not in any
property names/values. As such, they can all easily be fixed without
impacting any DT content or ABI.
