From: broonie@kernel.org (Mark Brown)
Date: Tue, 17 Nov 2015 16:53:28 +0000
Subject: [PATCH 0/8] spi: Add file i/o to spidev_test
In-Reply-To: <2760715.DGIOLUoqL9@jclayton-pc>
References: <cover.1447773299.git.stillcompiling@gmail.com>
 <20151117153746.GS31303@sirena.org.uk>
 <2760715.DGIOLUoqL9@jclayton-pc>
Message-ID: <20151117165328.GT31303@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 17, 2015 at 08:15:45AM -0800, Joshua Clayton wrote:
> On Tuesday, November 17, 2015 03:37:46 PM Mark Brown wrote:
> > On Tue, Nov 17, 2015 at 07:24:20AM -0800, Joshua Clayton wrote:

> > >   Documentation/spi/spidev_test.c: use one rx buffer
> > >   Documentation/spi/spidev_test.c: clean up input_tx
> > >   Documentation/spi/spidev_test.c: accept input from a file
> > >   Documentation/spi/spidev_test.c: output to a file
> > >   Documentation/spi/spidev_test.c: check error
> > >   Documentation/spi/spidev_test.c: fix whitespace

> > Please use subjct lines reflecting the style for the subsystem.

> OK. Will do.
> Assuming "spi: spidev_test: yadda..." 

Something like that.

> It was a bit unclear due to the location of the file.

It's not really the location that you should be focusing on, it's other
commits in the file.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151117/a48258ac/attachment.sig>
