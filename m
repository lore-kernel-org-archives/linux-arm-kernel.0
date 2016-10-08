From: Rob Herring <robh@kernel.org>
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Jyri Sarha <jsarha@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>,
	David Airlie <airlied@linux.ie>,
	Kevin Hilman <khilman@baylibre.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Sekhar Nori <nsekhar@ti.com>, Frank Rowand <frowand.list@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	arm-soc <linux-arm-kernel@lists.infradead.org>,
	linux-drm <dri-devel@lists.freedesktop.org>,
	linux-devicetree <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3] drm: tilcdc: add a da850-specific compatible string
Message-ID: <20161008231521.GA10920@rob-hp-laptop>
References: <1475509519-29516-1-git-send-email-bgolaszewski@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1475509519-29516-1-git-send-email-bgolaszewski@baylibre.com>
Date: Sat, 8 Oct 2016 18:15:24 -0500
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
