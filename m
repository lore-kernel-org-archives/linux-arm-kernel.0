From: rric@kernel.org (Robert Richter)
Date: Thu, 31 Jul 2014 13:33:51 +0200
Subject: [PATCH 2/5] arm64, thunder: Add initial dts for Cavium Thunder SoC
In-Reply-To: <201407311224.14097.arnd@arndb.de>
References: <1406732794-20920-1-git-send-email-rric@kernel.org>
 <1406732794-20920-3-git-send-email-rric@kernel.org>
 <201407311224.14097.arnd@arndb.de>
Message-ID: <20140731113351.GR4703@rric.localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31.07.14 12:24:13, Arnd Bergmann wrote:
> On Wednesday 30 July 2014, Robert Richter wrote:
> > +/*
> > + * Cavium Thunder DTS file
> > + *
> > + * Copyright (C) 2013, Cavium Inc.
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License as
> > + * published by the Free Software Foundation; either version 2 of
> > + * the License, or (at your option) any later version.
> > + */
> 
> I think it makes sense to use a permissive license for these files here,
> since board vendors may want to include a copy of the binary in their
> firmware, which isn't necessarily GPL compatible.
> 
> What is Cavium's interest in making this GPL?

See my response to Rob's mail on this.

-Robert
