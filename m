From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 28 Jul 2017 07:53:37 +0200
Subject: [PATCH v2] ARM: dts: exynos: fix PCI bus dtc warnings
In-Reply-To: <20170726210943.6875-2-robh@kernel.org>
References: <20170726210943.6875-1-robh@kernel.org>
 <20170726210943.6875-2-robh@kernel.org>
Message-ID: <20170728055337.GA2805@kozik-book>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 26, 2017 at 04:09:38PM -0500, Rob Herring wrote:
> dtc recently added PCI bus checks. Fix these warnings.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Javier Martinez Canillas <javier@osg.samsung.com>
> Cc: linux-samsung-soc at vger.kernel.org
> ---
> v2:
> - rebase on v4.13-rc2
> 
>  arch/arm/boot/dts/exynos5440.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 

Thanks, applied.

Best regards,
Krzysztof
