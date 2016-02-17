From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 17 Feb 2016 16:01:46 +0100
Subject: [PATCH 01/13] spi: imx: allow only WML aligned transfers to use
 DMA
In-Reply-To: <20160217141619.GR7544@sirena.org.uk>
References: <1455715739-25161-1-git-send-email-s.hauer@pengutronix.de>
 <1455715739-25161-2-git-send-email-s.hauer@pengutronix.de>
 <20160217141619.GR7544@sirena.org.uk>
Message-ID: <20160217150146.GC3939@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 17, 2016 at 02:16:19PM +0000, Mark Brown wrote:
> On Wed, Feb 17, 2016 at 02:28:47PM +0100, Sascha Hauer wrote:
> 
> > Also removing change introduced in f6ee9b582d2db652497b73c1f117591dfb6d3a90
> > since this change only fix usecases with transfer size from 33 to 128 bytes
> > and doesn't fix 129 bytes and bigger.
> 
> Please include human readable descriptions of things like commits and
> issues being discussed in e-mail in your mails, this makes them much
> easier for humans to read especially when they have no internet access.
> I do frequently catch up on my mail on flights or while otherwise
> travelling so this is even more pressing for me than just being about
> making things a bit easier to read.

You seem to have a template for this, I remember having read the same
text before ;)

Will fix this and add a signed-off-by.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
