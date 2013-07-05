From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 06 Jul 2013 01:12:05 +0200
Subject: [PATCH V4 2/4] phy: Add driver for Exynos DP PHY
In-Reply-To: <000b01ce76ff$cf9fd6a0$6edf83e0$@samsung.com>
References: <000b01ce76ff$cf9fd6a0$6edf83e0$@samsung.com>
Message-ID: <1543218.1F6S8MDx2p@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 02 of July 2013 17:40:31 Jingoo Han wrote:
> Add a PHY provider driver for the Samsung Exynos SoC DP PHY.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Acked-by: Felipe Balbi <balbi@ti.com>
> ---
>  .../devicetree/bindings/phy/samsung-phy.txt        |    8 ++
>  drivers/phy/Kconfig                                |    6 ++
>  drivers/phy/Makefile                               |    1 +
>  drivers/phy/phy-exynos-dp-video.c                  |  111
> ++++++++++++++++++++ 4 files changed, 126 insertions(+)
>  create mode 100644 drivers/phy/phy-exynos-dp-video.c

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz
