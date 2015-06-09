From: mika.westerberg@linux.intel.com (Mika Westerberg)
Date: Tue, 9 Jun 2015 11:54:36 +0300
Subject: [PATCH] spi: spi-pxa2xx: remove legacy PXA DMA bits
In-Reply-To: <1433795557-18036-1-git-send-email-robert.jarzmik@free.fr>
References: <1433795557-18036-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <20150609085436.GE1478@lahna.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 08, 2015 at 10:32:37PM +0200, Robert Jarzmik wrote:
> From: Daniel Mack <zonque@gmail.com>
> 
> Generic DMA support was already implemented by commit cd7bed003404
> ("spi/pxa2xx: break out the private DMA API usage into a separate file")
> which moved all the legacy PXA DMA implementation code into its own
> file.
> 
> With generic DMA available for PXA, we can now just trash this file.
> 
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

> Acked-by: Mark Brown <broonie@linaro.org>
> [respin after pxa dmaengine support upstream]
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
