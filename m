From: gregkh@linuxfoundation.org (Greg KH)
Date: Wed, 18 Apr 2012 15:02:26 -0700
Subject: [PATCH v3 7/10] iio: lpc32xx-adc: Remove driver conflict due to
 device tree
In-Reply-To: <1334756176-25144-8-git-send-email-stigge@antcom.de>
References: <1334756176-25144-1-git-send-email-stigge@antcom.de>
 <1334756176-25144-8-git-send-email-stigge@antcom.de>
Message-ID: <20120418220226.GA8035@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 18, 2012 at 03:36:12PM +0200, Roland Stigge wrote:
> Previously, the touchscreen and ADC drivers of the LPC32xx SoC had a Kconfig
> conflict declared because they use the same hardware. Upon the introduction of
> device tree support in both drivers, the conflict must be removed to enable
> the same kernel to support different hardware (configured via the device tree).
> 
> Signed-off-by: Roland Stigge <stigge@antcom.de>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
