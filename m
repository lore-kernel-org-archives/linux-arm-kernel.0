From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 9 May 2012 15:28:37 +0100
Subject: [PATCH 05/10] ARM: Samsung: Update the device names for spi
 clock lookup
In-Reply-To: <CAJuYYwQ+Wn11puF7AdPD41Jntbuj7oZHqNfzQA2T8V=2cigQnw@mail.gmail.com>
References: <1336514694-22393-1-git-send-email-thomas.abraham@linaro.org>
 <1336514694-22393-6-git-send-email-thomas.abraham@linaro.org>
 <20120509085249.GA28702@sirena.org.uk>
 <CAJuYYwQ+Wn11puF7AdPD41Jntbuj7oZHqNfzQA2T8V=2cigQnw@mail.gmail.com>
Message-ID: <20120509142836.GT3955@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 09, 2012 at 09:40:26PM +0800, Thomas Abraham wrote:
> On 9 May 2012 16:52, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> > This should've been squashed into the patch that updated to use driver
> > data in order to avoid breaking bisection.

> This patch updates clock devname in the platform code and the
> modifications to use driver data is in the driver file. So these two
> changes are kept separate to allow them to be applied to their
> respective trees.

This means that bisection will be broken - anything with only one tree
won't be able to load the SPI driver successfully until it's merged
with the other which isn't ideal.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120509/fee290ec/attachment.sig>
