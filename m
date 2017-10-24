From: robh@kernel.org (Rob Herring)
Date: Tue, 24 Oct 2017 11:32:47 -0500
Subject: [PATCH 04/10] drm/sun4i: Add support for A10 display pipeline
 components
In-Reply-To: <20171017121807.2994-5-wens@csie.org>
References: <20171017121807.2994-1-wens@csie.org>
 <20171017121807.2994-5-wens@csie.org>
Message-ID: <20171024163247.oqpm42esvufaeim4@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 17, 2017 at 08:18:01PM +0800, Chen-Yu Tsai wrote:
> The A10 display pipeline has 2 frontends, 2 backends, and 2 TCONs.
> This patch adds support (or a compatible string in the frontend's
> case) for these components.
> 
> The TCONs support directly outputting to CPU/RGB/LVDS LCD panels,
> or it can output to HDMI via an on-chip HDMI controller, or
> CVBS/YPbPr/VGA signals via on-chip TV encoders. These additional
> encoders are not covered in this patch.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 3 +++
>  drivers/gpu/drm/sun4i/sun4i_backend.c                         | 8 ++++++++
>  drivers/gpu/drm/sun4i/sun4i_drv.c                             | 4 +++-
>  3 files changed, 14 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
