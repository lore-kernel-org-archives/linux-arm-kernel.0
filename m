From: robh@kernel.org (Rob Herring)
Date: Tue, 1 May 2018 09:08:40 -0500
Subject: [RFC 03/10] cpufreq: exynos: Remove support for Exynos5440
In-Reply-To: <20180424203239.21885-4-krzk@kernel.org>
References: <20180424203239.21885-1-krzk@kernel.org>
 <20180424203239.21885-4-krzk@kernel.org>
Message-ID: <20180501140840.GA27306@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 24, 2018 at 10:32:32PM +0200, Krzysztof Kozlowski wrote:
> The Exynos5440 is not actively developed, there are no development
> boards available and probably there are no real products with it.
> Remove wide-tree support for Exynos5440.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  .../bindings/cpufreq/cpufreq-exynos5440.txt        |  28 --
>  drivers/cpufreq/Kconfig.arm                        |  14 -
>  drivers/cpufreq/Makefile                           |   1 -
>  drivers/cpufreq/exynos5440-cpufreq.c               | 452 ---------------------
>  4 files changed, 495 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-exynos5440.txt
>  delete mode 100644 drivers/cpufreq/exynos5440-cpufreq.c

Reviewed-by: Rob Herring <robh@kernel.org>
