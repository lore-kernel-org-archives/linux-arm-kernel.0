From: robh@kernel.org (Rob Herring)
Date: Wed, 18 Jan 2017 17:14:02 -0600
Subject: [PATCH 4/4] drm: exynos: Remove support for Exynos4415 (SoC not
 supported anymore)
In-Reply-To: <20170114123642.15581-5-krzk@kernel.org>
References: <20170114123642.15581-1-krzk@kernel.org>
 <20170114123642.15581-5-krzk@kernel.org>
Message-ID: <20170118231402.xxje54gag3mb6b3x@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 14, 2017 at 02:36:42PM +0200, Krzysztof Kozlowski wrote:
> Support for Exynos4415 is going away because there are no internal nor
> external users.
> 
> Since commit 46dcf0ff0de3 ("ARM: dts: exynos: Remove exynos4415.dtsi"),
> the platform cannot be instantiated so remove also the drivers.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  .../devicetree/bindings/display/exynos/exynos_dsim.txt |  1 -
>  .../bindings/display/exynos/samsung-fimd.txt           |  1 -

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/gpu/drm/exynos/exynos_drm_dsi.c                | 15 +--------------
>  drivers/gpu/drm/exynos/exynos_drm_fimd.c               | 18 ++----------------
>  4 files changed, 3 insertions(+), 32 deletions(-)
