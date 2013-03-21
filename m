From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 21 Mar 2013 22:08:10 +0100
Subject: [PATCH 5/5] arm: dts: Convert mvebu device tree files to 64 bits
In-Reply-To: <20130321203751.GP21478@lunn.ch>
References: <1363883179-1361-1-git-send-email-gregory.clement@free-electrons.com>
 <1363883179-1361-6-git-send-email-gregory.clement@free-electrons.com>
 <20130321201533.GN21478@lunn.ch> <20130321212236.1015295d@skate>
 <20130321203751.GP21478@lunn.ch>
Message-ID: <20130321220810.0c055f57@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Lunn,

On Thu, 21 Mar 2013 21:37:51 +0100, Andrew Lunn wrote:

> > And I'm not sure the SDRAM address decoding windows allows to split the
> > first 4 GB of RAM into two areas, one that would be mapped starting at
> > physical address 0x0, and another area that would be mapped at a
> > different address (above 4 GB).
> 
> So why not map the whole SDRAM above 4GB physical address?

That's a good question. The problem is most likely that this would
require to synchronize with U-Boot modifications, which is not easy to
achieve.

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
