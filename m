From: lars@metafoo.de (Lars-Peter Clausen)
Date: Mon, 7 Mar 2016 21:04:15 +0100
Subject: [PATCH v2 2/2] iio:adc:at91-sama5d2: add support for signed
 conversion
In-Reply-To: <1457360997-29179-3-git-send-email-ludovic.desroches@atmel.com>
References: <1457360997-29179-1-git-send-email-ludovic.desroches@atmel.com>
 <1457360997-29179-3-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <56DDDEBF.30905@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/07/2016 03:29 PM, Ludovic Desroches wrote:
> The at91-sama5d2 ADC controller can achieve unsigned and signed
> conversions. For each channel, a signed and an unsigned variant are
> created.
> Sign mode is a global configuration, it is not tied to a specific
> channel. For this reason, the controller has to be configured upon
> conversion request.

So, what's the difference between signed and unsigned mode?
