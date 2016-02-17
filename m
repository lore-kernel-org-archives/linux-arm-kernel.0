From: broonie@kernel.org (Mark Brown)
Date: Wed, 17 Feb 2016 14:16:19 +0000
Subject: [PATCH 01/13] spi: imx: allow only WML aligned transfers to use
 DMA
In-Reply-To: <1455715739-25161-2-git-send-email-s.hauer@pengutronix.de>
References: <1455715739-25161-1-git-send-email-s.hauer@pengutronix.de>
 <1455715739-25161-2-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20160217141619.GR7544@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 17, 2016 at 02:28:47PM +0100, Sascha Hauer wrote:

> Also removing change introduced in f6ee9b582d2db652497b73c1f117591dfb6d3a90
> since this change only fix usecases with transfer size from 33 to 128 bytes
> and doesn't fix 129 bytes and bigger.

Please include human readable descriptions of things like commits and
issues being discussed in e-mail in your mails, this makes them much
easier for humans to read especially when they have no internet access.
I do frequently catch up on my mail on flights or while otherwise
travelling so this is even more pressing for me than just being about
making things a bit easier to read.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160217/6dbb2cba/attachment.sig>
