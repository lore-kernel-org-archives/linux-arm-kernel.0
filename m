From: robh@kernel.org (Rob Herring)
Date: Sat, 8 Oct 2016 20:29:08 -0500
Subject: [PATCH v3] drm: tilcdc: add a da850-specific compatible string
In-Reply-To: <1475509519-29516-1-git-send-email-bgolaszewski@baylibre.com>
References: <1475509519-29516-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <20161009012908.GP18158@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 03, 2016 at 05:45:19PM +0200, Bartosz Golaszewski wrote:
> Due to some potential tweaks for the da850 LCDC (for example: the
> required memory bandwith settings) we need a separate compatible
> for the IP present on the da850 boards.
> 
> Suggested-by: Sekhar Nori <nsekhar@ti.com>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
> v1 -> v2:
> - added the new compatible to the bindings documentation
> 
> v2 -> v3:
> - made the documentation more detailed
> 
>  Documentation/devicetree/bindings/display/tilcdc/tilcdc.txt | 6 ++++--
>  drivers/gpu/drm/tilcdc/tilcdc_drv.c                         | 1 +
>  2 files changed, 5 insertions(+), 2 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
