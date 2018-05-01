From: robh@kernel.org (Rob Herring)
Date: Tue, 1 May 2018 09:08:01 -0500
Subject: [RFC 02/10] ata: ahci-platform: Remove support for Exynos5440
In-Reply-To: <20180424203239.21885-3-krzk@kernel.org>
References: <20180424203239.21885-1-krzk@kernel.org>
 <20180424203239.21885-3-krzk@kernel.org>
Message-ID: <20180501140801.GA27080@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 24, 2018 at 10:32:31PM +0200, Krzysztof Kozlowski wrote:
> The Exynos5440 is not actively developed, there are no development
> boards available and probably there are no real products with it.
> Remove wide-tree support for Exynos5440.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  Documentation/devicetree/bindings/ata/ahci-platform.txt | 1 -
>  drivers/ata/ahci_platform.c                             | 1 -
>  2 files changed, 2 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
