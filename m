From: broonie@kernel.org (Mark Brown)
Date: Thu, 17 May 2018 13:54:37 +0900
Subject: [PATCH v3 5/6] spi: at91-usart: add driver for at91-usart as spi
In-Reply-To: <c23cdde58b9f724f51787c6c38478df983be6efa.camel@microchip.com>
References: <20180511103822.31698-1-radu.pirea@microchip.com>
 <20180511103822.31698-6-radu.pirea@microchip.com>
 <CAHp75Ve3Ugnjjm8EZkPQTZSvH1qad1e5SqjOn8zz5syHSQea_g@mail.gmail.com>
 <5a3930b867cf8c279953d08c5d5dd1d93113a43b.camel@microchip.com>
 <CAHp75VdRrL25Jgnbk64Qqc5RY3uJdcntJ3xwRdp3F+rRFeTHBA@mail.gmail.com>
 <c23cdde58b9f724f51787c6c38478df983be6efa.camel@microchip.com>
Message-ID: <20180517045437.GE20254@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 15, 2018 at 12:22:24PM +0300, Radu Pirea wrote:
> On Mon, 2018-05-14 at 20:38 +0300, Andy Shevchenko wrote:

> > So, what is not going as expected in "SPI core takes care of CSs"
> > case?
> > Did you use oscilloscope for that?

> Yes, I used and CSs was not asserted. Anyway, I will will try again.

If the core chip select handling is not working properly for some reason
then the core chip select handling should be fixed rather than just open
coding in your driver - probably it's also broken for other users.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180517/795c8270/attachment-0001.sig>
