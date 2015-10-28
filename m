From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 28 Oct 2015 10:52:58 +0900
Subject: [PATCH v2 0/4] Exynos SROMc configuration and Ethernet support for
 SMDK5410
In-Reply-To: <cover.1445935215.git.p.fedin@samsung.com>
References: <cover.1445935215.git.p.fedin@samsung.com>
Message-ID: <56302A7A.1070105@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27.10.2015 17:43, Pavel Fedin wrote:
> This patch extends Exynos SROM controller driver with ability to configure
> controller outputs and enables SMSC9115 Ethernet chip on SMDK5410 board,
> which is connected via SROMc bank #3.
> 
> With this patchset, support for the whole existing SMDK range can be added.
> Actually, only bank number is different.
> 
> This patchset also depends on Exynos 5410 pinctrl support, introduced by
> patches 0003 and 0004 from this set:
> [PATCH v4 0/5] ARM: EXYNOS: ODROID-XU DT and LEDs
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/330862.html
> 
> Pinctrl support is necessary in order to correctly configure
> multifunctional pins of the Exynos chip.
> 
> v1 => v2:
> - Fixed some typos and bad labels in device tree
> - Improved documentation
> 
> Pavel Fedin (4):
>   ARM: dts: Add SROMc to Exynos 5410
>   drivers: exynos-srom: Add support for bank configuration
>   ARM: dts: Add Ethernet chip to SMDK5410
>   Documentation: dt-bindings: Describe SROMc configuration
> 

The bindings documentation goes first.

Best regards,
Krzysztof
