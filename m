From: robh@kernel.org (Rob Herring)
Date: Mon, 8 May 2017 11:20:23 -0500
Subject: [PATCH v2 16/20] dt-bindings: display: sun4i: Add HDMI display
 bindings
In-Reply-To: <0941a11259b2dba88d235c6ad713e3451d385028.1493812478.git-series.maxime.ripard@free-electrons.com>
References: <cover.d697f34bb7b0605c5e76cbc4167a64453e5e0984.1493812478.git-series.maxime.ripard@free-electrons.com>
 <0941a11259b2dba88d235c6ad713e3451d385028.1493812478.git-series.maxime.ripard@free-electrons.com>
Message-ID: <20170508162023.nseoybdkmwdz7sls@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 03, 2017 at 01:59:53PM +0200, Maxime Ripard wrote:
> One of the possible output of the display pipeline, on the SoCs that have
> it, is the HDMI controller.
> 
> Add a binding for it.
> 
> Acked-by: Chen-Yu Tsai <wens@csie.org>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 79 +++++++-
>  1 file changed, 79 insertions(+), 0 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
