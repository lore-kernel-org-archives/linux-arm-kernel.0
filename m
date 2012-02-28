From: gregkh@linuxfoundation.org (Greg KH)
Date: Tue, 28 Feb 2012 09:28:51 -0800
Subject: [PATCH] tty: serial: OMAP: Fix oops due to NULL pdata in DT boot
In-Reply-To: <4F4D0D44.3010604@ti.com>
References: <20120126024903.31613.24730.stgit@dusk>
 <20120126025036.31613.67819.stgit@dusk> <4F4D0D44.3010604@ti.com>
Message-ID: <20120228172851.GA13653@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 28, 2012 at 06:22:12PM +0100, Cousson, Benoit wrote:
> The following commit: be4b0281956c5cae4f63f31f11d07625a6988766
> (tty: serial: OMAP: block idle while the UART is transferring data in PIO mode),
> is introducing an oops if OMAP is booted using device tree blob because
> the pdata will not be initialized.

Is that something that happens today on systems?  Does this need to go
in for 3.3-final, or can it wait for 3.4?

thanks,

greg k-h
