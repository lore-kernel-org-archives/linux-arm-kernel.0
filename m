From: broonie@kernel.org (Mark Brown)
Date: Thu, 4 Jun 2015 18:01:12 +0100
Subject: next-20150604 build: 2 failures 37 warnings (next-20150604)
In-Reply-To: <E1Z0YIL-0008Ma-5O@optimist>
References: <E1Z0YIL-0008Ma-5O@optimist>
Message-ID: <20150604170112.GM14071@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 04, 2015 at 05:47:05PM +0100, Build bot for Mark Brown wrote:

> 	arm-allmodconfig
> ../drivers/tty/serial/8250/8250_omap.c:586:20: error: redefinition of 'omap8250_irq'

Current -next fails to build an ARM allmodconfig (and possibly other
things) due to 9e91597f24234 and 9809889c708eb (serial: 8250_omap:
provide complete custom startup & shutdown callbacks) which appear to be
the same commit that's been applied twice somehow.  Not sure what's
going on there...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150604/76cb80de/attachment.sig>
