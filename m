From: broonie@kernel.org (Mark Brown)
Date: Tue, 9 Jun 2015 12:11:22 +0100
Subject: [PATCH] spi: spi-pxa2xx: remove legacy PXA DMA bits
In-Reply-To: <1433795557-18036-1-git-send-email-robert.jarzmik@free.fr>
References: <1433795557-18036-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <20150609111122.GB14071@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 08, 2015 at 10:32:37PM +0200, Robert Jarzmik wrote:
> From: Daniel Mack <zonque@gmail.com>
> 
> Generic DMA support was already implemented by commit cd7bed003404
> ("spi/pxa2xx: break out the private DMA API usage into a separate file")
> which moved all the legacy PXA DMA implementation code into its own
> file.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150609/39c50937/attachment.sig>
