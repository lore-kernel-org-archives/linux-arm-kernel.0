From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Thu, 8 Sep 2016 14:04:40 +0200
Subject: [PATCH 0/2] spi: meson: Add Amlogic GXBB compatible
In-Reply-To: <1473321206-32284-1-git-send-email-narmstrong@baylibre.com>
References: <1473321206-32284-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <293061a8-e867-4d91-20cb-6e5df8e9b543@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 08.09.2016 um 09:53 schrieb Neil Armstrong:
> This patchset adds a specific compatible string in the Meson SPIFC driver for
> the Amlogic Meson GXBB SoC.

Any particular reason? We could just reuse the meson6 one since there
appear to be no code changes so far.

Regards,
Andreas

> This patchset is SPI-only respin from Jerome Brunet patchset at [1].
> 
> [1] http://lkml.kernel.org/r/1473261223-15412-1-git-send-email-jbrunet at baylibre.com
> 
> Neil Armstrong (2):
>   dt-bindings: spi-meson: Add GXBB Compatible string
>   spi: meson: Add GXBB compatible
> 
>  Documentation/devicetree/bindings/spi/spi-meson.txt | 2 +-
>  drivers/spi/spi-meson-spifc.c                       | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
