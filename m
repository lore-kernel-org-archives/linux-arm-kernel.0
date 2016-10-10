From: robh@kernel.org (Rob Herring)
Date: Mon, 10 Oct 2016 09:49:46 -0500
Subject: [PATCH 5/9] drm/sun4i: Add compatible strings for A31/A31s
 display pipelines
In-Reply-To: <20161006160629.11198-6-wens@csie.org>
References: <20161006160629.11198-1-wens@csie.org>
 <20161006160629.11198-6-wens@csie.org>
Message-ID: <20161010144946.GA23721@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 07, 2016 at 12:06:25AM +0800, Chen-Yu Tsai wrote:
> The A31's display pipeline has 2 frontends, 2 backends, and 2 TCONs. It
> also has new display enhancement blocks, such as the DRC (Dynamic Range
> Controller), the DEU (Display Enhancement Unit), and the CMU (Color
> Management Unit). It supports HDMI, MIPI DSI, and 2 LCD/LVDS channels.
> 
> The A31s display pipeline is almost the same, just without MIPI DSI.
> Only the TCON seems to be different, due to the missing mux for MIPI
> DSI.
> 
> Add compatible strings for both of them.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 4 ++++
>  drivers/gpu/drm/sun4i/sun4i_backend.c                         | 1 +
>  drivers/gpu/drm/sun4i/sun4i_drv.c                             | 3 +++
>  3 files changed, 8 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
