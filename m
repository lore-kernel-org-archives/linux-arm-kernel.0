From: daniel@caiaq.de (Daniel Mack)
Date: Thu, 19 Nov 2009 18:27:08 +0100
Subject: MX3 SDMA?
Message-ID: <20091119172708.GN14091@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I wonder whether anyone is currently working on porting the SDMA engie
from Freescale's BSPs to mainline?

If not, what would be a sane approach to start that? From what I've
seen, there is support specifically for the SoC's on-chip peripherals
which could be implemented with an API similar to the clock framework
(ie, matching via device names).

As this engine features an own RISC processor and is a huge monster, I
would assume starting with supporting a subset of features would make
sense.

Plans, ideas?

Any pointers welcome.

Thanks,
Daniel
