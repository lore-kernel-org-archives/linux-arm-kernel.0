From: mike@mwester.net (Mike Westerhof)
Date: Sun, 15 Nov 2009 12:41:32 -0600
Subject: IXP4xx: unneeded #include platform-specific include files?
In-Reply-To: <m3fx8fso72.fsf@intrepid.localdomain>
References: <m3fx8fso72.fsf@intrepid.localdomain>
Message-ID: <4B004B5C.7000306@mwester.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Krzysztof Halasa wrote:
> I wonder about one more thing: why are the platform-specific include
> files included by the non-platform code?
> 
> mach-ixp4xx/include/mach/hardware.h:
> 
> /* Platform specific details */
> #include "ixdp425.h"
> #include "avila.h"
> #include "coyote.h"
> #include "prpmc1100.h"
> #include "nslu2.h"
> #include "nas100d.h"
> #include "dsmg600.h"
> #include "fsg.h"
> 
> I'm going to move them to the platform code, either incorporate them
> into platform .c files or #include "specific-platform.h" from there.
> 
> Objections?

None at all (for nslu2 and dsmg600 platforms).
-Mike (mwester)
