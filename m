From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 7 Mar 2012 09:49:39 +0100
Subject: AMBA devices behing a PCI bridge
In-Reply-To: <20120222191339.GA28388@mail.gnudd.com>
References: <20120222191339.GA28388@mail.gnudd.com>
Message-ID: <CACRpkdYv02sNAcTSPgW-aq8iL6mAhcY2XTDV1BztPS_NvYqYXA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 22, 2012 at 8:13 PM, Alessandro Rubini <ru@gnudd.com> wrote:

> Hello Russell.
> I'm working, with some mates, on a device which is basically a bridge
> from PCIe to AMBA.
>
> Some of the peripherals that live behind the bridge are actually
> normal primecell devices, with minor or no modifications from the
> original ARM cores. The list includes dma, uart, spi, i2c and mmc.

Just watching from the side this is very interesting, and of course it is
wise to reuse the existing PrimeCell drivers, given the effort that has
been put into maintaining and generalizing them over the last few
years.

Thanks for looking into this and I'll be happy to help out with the
review!

Yours,
Linus Walleij
