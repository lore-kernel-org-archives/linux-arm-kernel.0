From: broonie@kernel.org (Mark Brown)
Date: Fri, 4 Jul 2014 23:08:56 +0100
Subject: Android and compatibility with deprecated armv7 instructions
In-Reply-To: <6519224.oaibQ22oiI@wuerfel>
References: <CAOesGMh25XO=PYSSTbYkoVrQER=09mnKt68LMbLVT4+dBa716w@mail.gmail.com>
 <20140704132250.A2447C40ADD@trevor.secretlab.ca>
 <20140704192405.GE14896@sirena.org.uk> <6519224.oaibQ22oiI@wuerfel>
Message-ID: <20140704220856.GL14896@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 04, 2014 at 09:33:24PM +0200, Arnd Bergmann wrote:
> On Friday 04 July 2014 20:24:05 Mark Brown wrote:

> > Another question I think it's worth asking is what the use case for 32
> > bit mode is other than preexisting binaries - I guess there's a case for
> > smaller binaries giving better cache utilisation?

> If you wanted that, you'd probably run x32-mode (or whatever it gets called
> on ARM64), which I'd expect to also be more efficient ;-)

Well, indeed.

> Seriously, backwards-compatibility is the only reason I can think of
> really, but that doesn't /have/ to mean existing binaries; there is a large
> amount of source code that can readily be compiled to any CPU as long as
> it's little-endian 32-bit.

Sure, and even some more that only runs if it's big endian 32 bit.
Definitely relatively esoteric compared to Android though, at least for
ARM for the time being.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140704/661eb3b1/attachment.sig>
