From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 30 Sep 2016 19:10:04 +0530
Subject: [PATCH] drm: tilcdc: add a da850-specific compatible string
In-Reply-To: <1475240456-22936-1-git-send-email-bgolaszewski@baylibre.com>
References: <1475240456-22936-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <a967b5b6-9238-169b-7587-8c9d1f40c99d@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 30 September 2016 06:30 PM, Bartosz Golaszewski wrote:
> Due to some potential tweaks for the da850 LCDC (for example: the
> required memory bandwith settings) we need a separate compatible
> for the IP present on the da850 boards.
> 
> Suggested-by: Sekhar Nori <nsekhar@ti.com>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/gpu/drm/tilcdc/tilcdc_drv.c | 1 +

This patch should document the new compatible in
Documentation/devicetree/bindings/..

Thanks,
Sekhar
