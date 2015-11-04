From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 04 Nov 2015 16:36:40 +0900
Subject: [PATCH v5 0/4] Exynos SROMc configuration and Ethernet support for
 SMDK5410
In-Reply-To: <cover.1446542020.git.p.fedin@samsung.com>
References: <cover.1446542020.git.p.fedin@samsung.com>
Message-ID: <5639B588.1080901@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03.11.2015 18:16, Pavel Fedin wrote:
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

Only the first patch made up to kernel. The rest (2-5) received feedback
and I am waiting for fixing it. Andreas apparently loose the interest...

Best regards,
Krzysztof
