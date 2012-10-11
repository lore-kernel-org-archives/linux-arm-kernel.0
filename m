From: afzal@ti.com (Mohammed, Afzal)
Date: Thu, 11 Oct 2012 05:24:58 +0000
Subject: [PATCH v2 00/14] OMAP-GPMC related cleanup for common zImage
In-Reply-To: <20121010163840.GA13585@parrot.com>
References: <cover.1349672877.git.afzal@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9F7B0A@DBDE01.ent.ti.com>
 <20121010163840.GA13585@parrot.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E9FB245@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 10, 2012 at 22:08:41, Ivan Djelic wrote:
> On Mon, Oct 08, 2012 at 07:08:08AM +0100, Mohammed, Afzal wrote:

> > Please verify that BCH[48] works as earlier with this series.

> I ran several mtd regression tests on a Beagle Board on your gpmc-czimage-v2 tag.
> All BCH error correcting tests passed successfully.
> 
> I occasionally had weird read errors though, especially when reading blank pages:
> the omap driver returned 512-byte sectors containing something like:

> I was able to reproduce the problem also on l2-mtd tip, albeit less often.
> The problem seems to occur quite randomly, it may be a hardware issue on
> my board...
> 
> Anyway, the ECC handling part looks OK to me.

Thanks Ivan

Regards
Afzal
