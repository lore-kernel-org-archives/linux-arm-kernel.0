From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Sep 2016 11:35:14 +0200
Subject: [GIT PULL 2/3] DaVinci dts updates for v4.9
In-Reply-To: <211a1af8-d76b-62af-08ac-a374d3285c0a@ti.com>
References: <20160824110006.1866-1-nsekhar@ti.com>
 <3347114.RAnckMhlMa@wuerfel> <211a1af8-d76b-62af-08ac-a374d3285c0a@ti.com>
Message-ID: <5560037.rRSHMQTY3J@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, September 15, 2016 2:11:03 PM CEST Sekhar Nori wrote:
> On Wednesday 14 September 2016 09:23 PM, Arnd Bergmann wrote:
> > On Wednesday, August 24, 2016 4:30:05 PM CEST Sekhar Nori wrote:
> > Can you send a fixed version please?
> 
> Did the merge happen cleanly? There should be no nand_cs3_pins if the
> merge was clean. It should be removed with 31e3a8817b66 ("ARM: dts:
> da850,da850-evm: Add an aemif node and use it for the NAND").
> 
> If the merge was clean, can you please push the offending tree to some
> place I can fetch and take a look. I dont have "nand_cs3_pins" in my
> tree anymore nor I can reproduce the build break.
> 
> 

I must have made a mistake, it now all works, sorry for the confusion.
I don't have the error in my scrollback buffer any more, but I suspect
that the file that caused the problem was not actually the .dts file
but the .dts.orig file from resolving the conflict.

Pulled it into next/dt now.

	Arnd
