From: robh@kernel.org (Rob Herring)
Date: Wed, 9 Nov 2016 12:24:33 -0600
Subject: [PATCH v2 2/5] ARM: bus: da8xx-mstpri: new driver
In-Reply-To: <1477925138-23457-3-git-send-email-bgolaszewski@baylibre.com>
References: <1477925138-23457-1-git-send-email-bgolaszewski@baylibre.com>
 <1477925138-23457-3-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <20161109182433.vskk5rn7hfxshfy6@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 31, 2016 at 03:45:35PM +0100, Bartosz Golaszewski wrote:
> Create the driver for the da8xx master peripheral priority
> configuration and implement support for writing to the three
> Master Priority registers on da850 SoCs.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  .../devicetree/bindings/bus/ti,da850-mstpri.txt    |  20 ++

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/bus/Kconfig                                |   9 +
>  drivers/bus/Makefile                               |   2 +
>  drivers/bus/da8xx-mstpri.c                         | 269 +++++++++++++++++++++
>  4 files changed, 300 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/bus/ti,da850-mstpri.txt
>  create mode 100644 drivers/bus/da8xx-mstpri.c
