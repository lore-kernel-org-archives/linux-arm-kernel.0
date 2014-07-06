From: emilio@elopez.com.ar (=?UTF-8?B?RW1pbGlvIEzDs3Bleg==?=)
Date: Sun, 06 Jul 2014 19:49:27 -0300
Subject: [PATCH v2 2/8] spi: sun4i: add DMA support
In-Reply-To: <1404619518-7592-3-git-send-email-emilio@elopez.com.ar>
References: <1404619518-7592-1-git-send-email-emilio@elopez.com.ar>
 <1404619518-7592-3-git-send-email-emilio@elopez.com.ar>
Message-ID: <53B9D277.9090208@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

El 06/07/14 01:05, Emilio L?pez escribi?:
> This patch adds DMA support for 64 byte transfers on the sun4i SPI
> controller. Bigger transfers did not seem to work when tested, and if
> the hardware actually supports those, it will need further
> investigation as to how to issue them correctly.

It seems I forgot to update this commit message; it should be something 
like:

This patch adds support for 64 byte or bigger transfers on the
sun4i SPI controller. Said transfers will be performed via DMA.

Many thanks to patapovich on #linux-sunxi for making me notice this.

Cheers,

Emilio
