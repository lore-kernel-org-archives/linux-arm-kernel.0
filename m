From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Wed, 28 Aug 2013 15:27:24 +0200
Subject: [PATCH v3 5/6] iio: at91: move the num_channels from DT to
 driver itself
In-Reply-To: <1377602932-1899-6-git-send-email-josh.wu@atmel.com>
References: <1377602932-1899-1-git-send-email-josh.wu@atmel.com>
 <1377602932-1899-6-git-send-email-josh.wu@atmel.com>
Message-ID: <20130828132724.GQ7468@ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 27, 2013 at 07:28:51PM +0800, Josh Wu wrote:
> CC: devicetree at vger.kernel.org
> Signed-off-by: Josh Wu <josh.wu@atmel.com>

Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>

> ---
>  Documentation/devicetree/bindings/arm/atmel-adc.txt |    1 -
>  drivers/iio/adc/at91_adc.c                          |   12 +++++-------
>  2 files changed, 5 insertions(+), 8 deletions(-)
