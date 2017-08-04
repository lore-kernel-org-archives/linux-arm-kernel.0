From: broonie@kernel.org (Mark Brown)
Date: Fri, 4 Aug 2017 12:43:26 +0100
Subject: [PATCH RFC 1/2] spi: pxa2xx: Convert to GPIO descriptor API
 where possible
In-Reply-To: <20170804102408.GX2369@lahna.fi.intel.com>
References: <cover.1501760433.git.jan.kiszka@siemens.com>
 <6bfd2b29b888c14f1a6feb9dee5bb54b74e761b0.1501760433.git.jan.kiszka@siemens.com>
 <20170804101029.GV2369@lahna.fi.intel.com>
 <b411858d-6a09-a3bc-555d-b1e648b9c8ed@siemens.com>
 <20170804102408.GX2369@lahna.fi.intel.com>
Message-ID: <20170804114326.isnsz6zgstpvuftt@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 04, 2017 at 01:24:08PM +0300, Mika Westerberg wrote:
> On Fri, Aug 04, 2017 at 12:18:28PM +0200, Jan Kiszka wrote:

> > It shouldn't cause problems (famous last words) because I refrained from
> > changing the interfaces to them. References that come in as legacy GPIO
> > are still treated like that.

> OK. I hope someone with a PXA2xx machine could still test it.

> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

This path should be very well covered - there's plenty of things that
convert GPIO numbers into descriptors out there.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170804/c50af111/attachment.sig>
