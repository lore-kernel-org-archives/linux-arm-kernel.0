From: broonie@kernel.org (Mark Brown)
Date: Tue, 11 Aug 2015 10:28:10 +0100
Subject: [RESEND][PATCH 3/4] ARM: davinci: Set proper SPI prescale limit
 value
In-Reply-To: <55C9BF51.5080401@ti.com>
References: <1437568344-18889-1-git-send-email-fcooper@ti.com>
 <1437568344-18889-4-git-send-email-fcooper@ti.com>
 <55B22681.3060000@ti.com> <55C9380D.1060802@ti.com>
 <55C99D0D.9050605@ti.com> <20150811090342.GG10748@sirena.org.uk>
 <55C9BF51.5080401@ti.com>
Message-ID: <20150811092810.GK10748@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 11, 2015 at 02:54:33PM +0530, Sekhar Nori wrote:
> On Tuesday 11 August 2015 02:33 PM, Mark Brown wrote:

> > Why would there be any interdependency between the the two trees, that
> > would be very unusual?  Adding a new value to DT doesn't need the kernel
> > to understand it and the driver should be compatible with existing DTs.
> > If there *is* some dependency that suggests the driver update has
> > problems...

> The dependency is because of platform data. Patch 2/4 adds a new
> platform data member 'prescaler_limit' which this patch populates for
> DaVinci devices using legacy booting.

Ugh, you still have legacy platforms :(

> > In any case I don't have a copy of the patch any more.

> I can resend this patch to you with my ack included.

I guess.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150811/b31df503/attachment.sig>
