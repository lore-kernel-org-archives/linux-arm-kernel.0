From: robh@kernel.org (Rob Herring)
Date: Sun, 10 Jan 2016 20:32:39 -0600
Subject: [PATCH v2 1/5] iio:adc:at91_adc8xx: introduce new atmel adc driver
In-Reply-To: <1452096759-19438-2-git-send-email-ludovic.desroches@atmel.com>
References: <1452096759-19438-1-git-send-email-ludovic.desroches@atmel.com>
 <1452096759-19438-2-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <20160111023239.GA27025@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 06, 2016 at 05:12:35PM +0100, Ludovic Desroches wrote:
> This driver supports the new version of the Atmel ADC device introduced
> with the SAMA5D2 SoC family.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> ---
>  .../devicetree/bindings/iio/adc/at91_adc8xx.txt    |  28 ++

For the binding:

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/iio/adc/Kconfig                            |  11 +
>  drivers/iio/adc/Makefile                           |   1 +
>  drivers/iio/adc/at91_adc8xx.c                      | 461 +++++++++++++++++++++
>  4 files changed, 501 insertions(+)
