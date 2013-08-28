From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Wed, 28 Aug 2013 15:25:59 +0200
Subject: [PATCH v3 2/6] iio: at91: introduce the multiple compatible
 string for different IPs.
In-Reply-To: <1377602932-1899-3-git-send-email-josh.wu@atmel.com>
References: <1377602932-1899-1-git-send-email-josh.wu@atmel.com>
 <1377602932-1899-3-git-send-email-josh.wu@atmel.com>
Message-ID: <20130828132559.GP7468@ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 27, 2013 at 07:28:48PM +0800, Josh Wu wrote:
> As use the multiple compatible string, we can remove hardware register in dt.
> 
> CC: devicetree at vger.kernel.org
> Signed-off-by: Josh Wu <josh.wu@atmel.com>

Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>

> ---
>  .../devicetree/bindings/arm/atmel-adc.txt          |    7 +-
>  arch/arm/mach-at91/include/mach/at91_adc.h         |    9 +++
>  drivers/iio/adc/at91_adc.c                         |   79 ++++++++++----------
>  3 files changed, 52 insertions(+), 43 deletions(-)
