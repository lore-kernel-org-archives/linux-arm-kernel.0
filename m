From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 9 May 2012 17:30:24 +0100
Subject: [PATCH 1/2] mfd: max8925: request resource region
In-Reply-To: <20120509161839.GB10241@n2100.arm.linux.org.uk>
References: <1336360249-29963-1-git-send-email-haojian.zhuang@gmail.com>
 <201205081444.30915.arnd@arndb.de>
 <20120508153155.GW15893@opensource.wolfsonmicro.com>
 <201205091243.13206.arnd@arndb.de>
 <20120509141316.GS3955@opensource.wolfsonmicro.com>
 <20120509161839.GB10241@n2100.arm.linux.org.uk>
Message-ID: <20120509163023.GH3955@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 09, 2012 at 05:18:39PM +0100, Russell King - ARM Linux wrote:
> On Wed, May 09, 2012 at 03:13:16PM +0100, Mark Brown wrote:

> > Yeah, I looked at that - PCMCIA seems to be the major sticking point and
> > the usage there appeared totally sane, though it's possible that if I
> > stare at it hard enough I might convince myself that it only needs seven
> > bits and we can steal one.

> Err what?  PCMCIA doesn't use IORESOURCE_BUS.  (Don't get it confused with
> IORESOURCE_BUSY which is totally different).

I've actually got it confused with IORESOURCE_BITS (because it's there
for bus-specific usage, as opposed to bus numbers) which it does use -
sorry.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120509/40e330c3/attachment.sig>
