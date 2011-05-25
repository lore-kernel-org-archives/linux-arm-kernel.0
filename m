From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 25 May 2011 14:47:43 +0200
Subject: [PATCH 2/2] dmaengine: add TODO items for future work on dma
	drivers
In-Reply-To: <1306323570-11133-3-git-send-email-vinod.koul@intel.com>
References: <1306323570-11133-1-git-send-email-vinod.koul@intel.com>
	<1306323570-11133-3-git-send-email-vinod.koul@intel.com>
Message-ID: <BANLkTinP-5z0ecf0zvrEnLOSDvOhLzMKDw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/5/25 Koul, Vinod <vinod.koul@intel.com>:

> From: Vinod Koul <vinod.koul@intel.com>
>
> Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> ---
> ?drivers/dma/TODO | ? 12 ++++++++++++
> ?1 files changed, 12 insertions(+), 0 deletions(-)
> ?create mode 100644 drivers/dma/TODO
>
> diff --git a/drivers/dma/TODO b/drivers/dma/TODO
> new file mode 100644
> index 0000000..b67d184
> --- /dev/null
> +++ b/drivers/dma/TODO
> @@ -0,0 +1,12 @@
> +TODO for slave dma
> +
> +1. Move remaining drivers to use new slave interface

Here is the hitlist:
- find arch/arm/ |grep -e "dma.c$"
- arch/arm/mach-s3c64xx/dma.c need to be merged into
  drivers/dma/amba-pl08x.c - make adjustments for local
  deviations

Or were you mainly talking about the drivers already in
drivers/dma?

Linus Walleij
