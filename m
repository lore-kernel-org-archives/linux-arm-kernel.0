From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 27 Nov 2014 17:49:50 +0100
Subject: [PATCH 00/11] ARM: at91: remove !DT support for at91rm9200
In-Reply-To: <cover.1417103399.git.nicolas.ferre@atmel.com>
References: <cover.1417103399.git.nicolas.ferre@atmel.com>
Message-ID: <3550407.q87bWB4Jdt@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 27 November 2014 17:06:28 Nicolas Ferre wrote:
> This is the last series of patches that removes the non-Device-Tree board
> support for older Atmel SoCs.
> Again, for the record, it was announced here
> https://lkml.org/lkml/2014/9/10/293 ([ANNOUNCE] ARM: at91: removal of board
> files) two months ago.
> Several files beyond at91rm9200 are touched this time as I tried to remove the
> biggest parts that were related to !DT SoC initializations. More cleanup is
> certainly needed to remove dead code.
> 
> The diffstat is also pretty big as a lot of at91rm9200 boards were remaining.
> 

Awesome stuff!

Two questions:

- is anything holding this up from getting merged in 3.19?

- Are there any remaining issues that keep us from using multiplatform?
  I know you all have been working on those a lot, but I haven't
  checked what is still missing.

	Arnd
