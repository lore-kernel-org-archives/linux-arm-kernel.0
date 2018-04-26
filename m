From: andi@etezian.org (andi at etezian.org)
Date: Thu, 26 Apr 2018 13:31:11 +0900
Subject: [RFC 01/10] ARM: dts: exynos: Remove Exynos5440
In-Reply-To: <20180424203239.21885-2-krzk@kernel.org>
References: <20180424203239.21885-1-krzk@kernel.org>
 <20180424203239.21885-2-krzk@kernel.org>
Message-ID: <66d27b987846172e290cbc587b9909ac@etezian.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

On 25.04.2018 05:32, Krzysztof Kozlowski wrote:
> The Exynos5440 (quad-core A15 with GMAC, PCIe, SATA) was targeting
> server platforms but it did not make it to the market really.  There 
> are
> no development boards with it and probably there are no real products
> neither.  The development for Exynos5440 ended in 2013 and since then
> the platform is in maintenance mode.
> 
> Remove all Device Tree sources for Exynos5440, as first step of removal
> of the platform to simplify the code and drivers.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

makes sense, please feel free to add:

Reviewed-by: Andi Shyti <andi@etezian.org>

Thanks,
Andi
