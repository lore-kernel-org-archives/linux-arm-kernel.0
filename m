From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 23 Mar 2017 21:37:11 +0200
Subject: [PATCH 04/15] ARM: dts: exynos: fix PCI bus dtc warnings
In-Reply-To: <20170322020313.24338-4-robh@kernel.org>
References: <20170322020313.24338-1-robh@kernel.org>
 <20170322020313.24338-4-robh@kernel.org>
Message-ID: <20170323193711.yu6nyjppformf3tb@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 21, 2017 at 09:03:02PM -0500, Rob Herring wrote:
> dtc recently added PCI bus checks. Fix these warnings.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Javier Martinez Canillas <javier@osg.samsung.com>
> Cc: linux-samsung-soc at vger.kernel.org
> ---
> Sub-arch maintainers, please apply to your trees unless arm-soc wants 
> to take the whole lot.
> 
>  arch/arm/boot/dts/exynos5440.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
>

Hi,

Unfortunately patch does not apply. There were some changes around PCIe
this release so I think the best way would be to rebase on top of linux-next.

Best regards,
Krzysztof
