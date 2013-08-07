From: broonie@kernel.org (Mark Brown)
Date: Wed, 7 Aug 2013 16:55:49 +0100
Subject: [PATCH 07/20] spi: spi-pxa2xx: remove legacy PXA DMA bits
In-Reply-To: <1375889649-14638-8-git-send-email-zonque@gmail.com>
References: <1375889649-14638-1-git-send-email-zonque@gmail.com>
 <1375889649-14638-8-git-send-email-zonque@gmail.com>
Message-ID: <20130807155549.GE6427@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 07, 2013 at 05:33:56PM +0200, Daniel Mack wrote:
> Generic DMA support was already implemented by commit cd7bed00
> ("spi/pxa2xx: break out the private DMA API usage into a separate
> file") which moved all the legacy PXA DMA implementation code into
> its own file.

Acked-by: Mark Brown <broonie@linaro.org>

though this will have some trivial merge issues until the merge window
they shouldn't be a problem.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130807/d7b7b370/attachment.sig>
