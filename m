From: broonie@kernel.org (Mark Brown)
Date: Tue, 31 May 2016 14:27:07 +0100
Subject: [PATCH 5/5] RFC spi: sun4i: add DMA support
In-Reply-To: <CAOMqctQijjO2amwSmSMGp96KBRGrLb0fvXRwnybOEqvV3-HZ0g@mail.gmail.com>
References: <cover.1464130597.git.hramrach@gmail.com>
 <ba0d6eb37cc4b0d2c46acbf9fcd7d644b3545ce8.1464130597.git.hramrach@gmail.com>
 <20160530112610.GJ29837@sirena.org.uk>
 <CAMuHMdVThvtqgFnyqoqypwwf1d81uu9NBo6-heTZBcvBxRevNw@mail.gmail.com>
 <20160530150343.GL29837@sirena.org.uk>
 <CAOMqctQb-YYprA7H5qCcYo2hxXiUhjW2z3JbZ3-FhbfcjFzBpw@mail.gmail.com>
 <20160530155016.GO29837@sirena.org.uk>
 <CAOMqctQijjO2amwSmSMGp96KBRGrLb0fvXRwnybOEqvV3-HZ0g@mail.gmail.com>
Message-ID: <20160531132706.GC29837@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 31, 2016 at 12:44:54PM +0200, Michal Suchanek wrote:
> On 30 May 2016 at 17:50, Mark Brown <broonie@kernel.org> wrote:
> > On Mon, May 30, 2016 at 05:28:10PM +0200, Michal Suchanek wrote:

> >> It's what the driver did to start with and it was requested to fall
> >> back to non-DMA in the case DMA is not available.

> > Why?  I really can't see any sensible use case for this that doesn't
> > have a better solution available.

> Of course, the solution is to compile in the DMA driver.

> It's been argued that some drivers which use only short transfers will
> just work.

With nothing else in the system that needs DMA?  It's making the
performance of the system less reliable for the benefit of a very narrow
use case.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160531/f521afd4/attachment.sig>
