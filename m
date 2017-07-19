From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Wed, 19 Jul 2017 12:26:23 +0200
Subject: [PATCH] media: Convert to using %pOF instead of full_name
In-Reply-To: <20170718214339.7774-33-robh@kernel.org>
References: <20170718214339.7774-33-robh@kernel.org>
Message-ID: <81c5f1c1-1c23-2a19-691e-811075be6010@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/18/2017 11:43 PM, Rob Herring wrote:
> Now that we have a custom printf format specifier, convert users of
> full_name to use %pOF instead. This is preparation to remove storing
> of the full path string for each node.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Andrzej Hajda <a.hajda@samsung.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
> Cc: Songjun Wu <songjun.wu@microchip.com>
> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Javier Martinez Canillas <javier@osg.samsung.com>
> Cc: Minghsiu Tsai <minghsiu.tsai@mediatek.com>
> Cc: Houlong Wei <houlong.wei@mediatek.com>
> Cc: Andrew-CT Chen <andrew-ct.chen@mediatek.com>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: "Niklas S?derlund" <niklas.soderlund@ragnatech.se>
> Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> Cc: Hyun Kwon <hyun.kwon@xilinx.com>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: "S?ren Brinkmann" <soren.brinkmann@xilinx.com>
> Cc: linux-media at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-samsung-soc at vger.kernel.org
> Cc: linux-mediatek at lists.infradead.org
> Cc: linux-renesas-soc at vger.kernel.org
> ---
>   drivers/media/i2c/s5c73m3/s5c73m3-core.c       |  3 +-
>   drivers/media/i2c/s5k5baf.c                    |  7 ++--
>   drivers/media/platform/am437x/am437x-vpfe.c    |  4 +-
>   drivers/media/platform/atmel/atmel-isc.c       |  4 +-
>   drivers/media/platform/davinci/vpif_capture.c  | 16 ++++----
>   drivers/media/platform/exynos4-is/fimc-is.c    |  8 ++--
>   drivers/media/platform/exynos4-is/fimc-lite.c  |  3 +-
>   drivers/media/platform/exynos4-is/media-dev.c  |  8 ++--
>   drivers/media/platform/exynos4-is/mipi-csis.c  |  4 +-
>   drivers/media/platform/mtk-mdp/mtk_mdp_comp.c  |  6 +--
>   drivers/media/platform/mtk-mdp/mtk_mdp_core.c  |  8 ++--

For mediatek parts:

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
