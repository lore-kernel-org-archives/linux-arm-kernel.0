From: broonie@kernel.org (Mark Brown)
Date: Mon, 13 Feb 2017 19:06:10 +0000
Subject: [PATCH] spi/sun6i: Add Master Sample Data Mode for SPI
In-Reply-To: <CAEz5UgEAYB94mC-6Oste4-tRRq16iXqBnJmjjhQFkqDmVO-nog@mail.gmail.com>
References: <20170213120553.6479-1-viniciusfre@gmail.com>
 <20170213183430.65vbm3cubid2ljkv@sirena.org.uk>
 <CAEz5UgEAYB94mC-6Oste4-tRRq16iXqBnJmjjhQFkqDmVO-nog@mail.gmail.com>
Message-ID: <20170213190610.ca37f36bv2d7efjh@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 13, 2017 at 04:00:09PM -0300, Vinicius Maciel wrote:
> Hi Mark,

Please don't top post, reply in line with needed context.  This allows
readers to readily follow the flow of conversation and understand what
you are talking about and also helps ensure that everything in the
discussion is being addressed.

> Sorry for the mess up. sun6i is a reference to the Allwinner A31 processor
> and sun7i is a reference to the Allwinner A20 processor. A31 uses
> spi-sun6i.c code, while A20 uses spi-sun4i.c code. Therefore, this is a
> different patch.
> About your recommedantion, I have to check with Maxine what can be done.

Usually duplicate patches to the two drivers are sent as a series to
make sure it's the same thing being done twice.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170213/64f2edb3/attachment.sig>
