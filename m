From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 9 May 2012 17:47:07 +0100
Subject: [PATCH 10/10] spi: s3c64xx: add device tree support
In-Reply-To: <CAJuYYwT6SJth83tFSbvENa2h7-M182kGCoBidmw8DvECK0qUzA@mail.gmail.com>
References: <1336514694-22393-1-git-send-email-thomas.abraham@linaro.org>
 <1336514694-22393-11-git-send-email-thomas.abraham@linaro.org>
 <20120509090716.GC28702@sirena.org.uk>
 <CAJuYYwQF9Hh3wJpPTfXm_5iirvHzgwDu6imuSgH-ggenj=Vc8Q@mail.gmail.com>
 <20120509143159.GU3955@opensource.wolfsonmicro.com>
 <CAJuYYwT6SJth83tFSbvENa2h7-M182kGCoBidmw8DvECK0qUzA@mail.gmail.com>
Message-ID: <20120509164706.GJ3955@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 10, 2012 at 12:39:29AM +0800, Thomas Abraham wrote:
> On 9 May 2012 22:32, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> > Yeah, I know. ?I'm saying we should try to come up with a binding for
> > this that can be used by new SPI contollers going forward so things are
> > consistent.

> Ok. For this patch series, I will continue with the samsung specific
> binding for the nCS line.

How about just renaming your binding to a generic one and documenting it
separately?  It looks like a sensible binding which other people should
be able to use so may as well have something there already.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120509/151225f4/attachment.sig>
