From: robh@kernel.org (Rob Herring)
Date: Mon, 10 Oct 2016 09:45:37 -0500
Subject: [PATCH 1/9] drm/sun4i: sun6i-drc: Support DRC on A31 and A31s
In-Reply-To: <20161006160629.11198-2-wens@csie.org>
References: <20161006160629.11198-1-wens@csie.org>
 <20161006160629.11198-2-wens@csie.org>
Message-ID: <20161010144537.GA22357@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 07, 2016 at 12:06:21AM +0800, Chen-Yu Tsai wrote:
> The A31 and A31s also have the DRC as part of the display pipeline.
> As we know virtually nothing about them, just add compatible strings
> for both SoCs to the stub driver.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 2 ++
>  drivers/gpu/drm/sun4i/sun6i_drc.c                             | 2 ++
>  2 files changed, 4 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
