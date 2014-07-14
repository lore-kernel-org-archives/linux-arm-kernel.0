From: broonie@kernel.org (Mark Brown)
Date: Mon, 14 Jul 2014 20:15:33 +0100
Subject: [PATCH 1/3 v6] spi: s3c64xx: fix broken "cs_gpios" usage in the
 driver
In-Reply-To: <CAHfPSqAzab931yurSs+3zj=uoFj93FuAdd24AQKm1fZm07Nq8Q@mail.gmail.com>
References: <1405316506-27855-1-git-send-email-ch.naveen@samsung.com>
 <1405316506-27855-2-git-send-email-ch.naveen@samsung.com>
 <20140714172524.GH6800@sirena.org.uk>
 <CAHfPSqAzab931yurSs+3zj=uoFj93FuAdd24AQKm1fZm07Nq8Q@mail.gmail.com>
Message-ID: <20140714191533.GH6800@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 15, 2014 at 12:31:32AM +0530, Naveen Krishna Ch wrote:

> in this case spi-s3c64xx.c will continue to ignore the generic SPI "cs-gpios"
> implementation.

> I'm willing to implement any suggestion to fix this issue.

The problem isn't what you're trying to do, the problem is verifying
that it has been done correctly - making sure that everything has been
accounted for in the change itself.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140714/ee3cad0e/attachment.sig>
