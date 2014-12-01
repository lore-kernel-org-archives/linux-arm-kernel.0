From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 1 Dec 2014 10:38:38 +0100
Subject: [PATCH v2 03/11] mfd: syscon: Add atmel-smc registers definition
In-Reply-To: <20141110095728.GJ21424@x1>
References: <1415203287-21517-1-git-send-email-boris.brezillon@free-electrons.com>
 <1415203287-21517-4-git-send-email-boris.brezillon@free-electrons.com>
 <20141110095728.GJ21424@x1>
Message-ID: <20141201103838.4a7a0ffa@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

Sorry for the late reply.

On Mon, 10 Nov 2014 09:57:28 +0000
Lee Jones <lee.jones@linaro.org> wrote:

> On Wed, 05 Nov 2014, Boris Brezillon wrote:
> 
> > Atmel AT91 SoCs have a memory range reserved for SMC (Static Memory
> > Controller) configuration.
> > Expose those registers so that drivers can make use of the smc syscon
> > declared in at91 DTs.
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > ---
> >  include/linux/mfd/syscon/atmel-smc.h | 60 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 60 insertions(+)
> >  create mode 100644 include/linux/mfd/syscon/atmel-smc.h
> 
> Acked-by: Lee Jones <lee.jones@linaro.org>
> 
> Any idea who will take this set?

I guess you could take patch 1 to 4 and Nicolas would take the other
ones (unless there's a maintainer for memory controller drivers).
Or, if we don't want to have dependency issues, Nicolas can take all of
them.

Nicolas, any preference ?

Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
