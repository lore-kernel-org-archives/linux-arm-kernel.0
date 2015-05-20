From: broonie@kernel.org (Mark Brown)
Date: Wed, 20 May 2015 11:13:18 +0100
Subject: [RFC PATCH 1/4] spi: spidev: Add Google SPI flash compatible
 string
In-Reply-To: <1432042454-19234-2-git-send-email-javier.martinez@collabora.co.uk>
References: <1432042454-19234-1-git-send-email-javier.martinez@collabora.co.uk>
 <1432042454-19234-2-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <20150520101318.GB21577@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 19, 2015 at 03:34:11PM +0200, Javier Martinez Canillas wrote:
> Google Chromebooks have a SPI flash that is used to store firmware and
> different system parameters and data (i.e: Google Binary Block flags).

> ---
>  drivers/spi/spidev.c | 1 +
>  1 file changed, 1 insertion(+)

This is adding a binding with no documentation, documentation is
mandatory for all bindings.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150520/ea1784dc/attachment.sig>
