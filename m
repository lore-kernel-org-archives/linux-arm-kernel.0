From: robh@kernel.org (Rob Herring)
Date: Mon, 22 May 2017 19:33:12 -0500
Subject: [PATCH v3 19/21] drm/sun4i: Add compatible for the A10s pipeline
In-Reply-To: <d1bc2420845061a9c057d47a5556c621f8bcd025.1495006350.git-series.maxime.ripard@free-electrons.com>
References: <cover.463df61c38224ecbfb5bf1cf192deeb63718b693.1495006350.git-series.maxime.ripard@free-electrons.com>
 <d1bc2420845061a9c057d47a5556c621f8bcd025.1495006350.git-series.maxime.ripard@free-electrons.com>
Message-ID: <20170523003312.33xdw4r3ngek4fot@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 17, 2017 at 09:40:48AM +0200, Maxime Ripard wrote:
> The A10s has a slightly different display pipeline than the A13, with an
> HDMI controller.
> 
> Add a compatible for it.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 1 +
>  drivers/gpu/drm/sun4i/sun4i_drv.c                             | 1 +
>  2 files changed, 2 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
