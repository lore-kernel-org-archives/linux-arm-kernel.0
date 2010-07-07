From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 07 Jul 2010 13:11:27 +0100
Subject: cortex-m3 on linux-2.6.33
In-Reply-To: <20100706180951.GR20855@pengutronix.de>
References: <AANLkTikEZcUjmAx7CpMXubH-pj5dSFiOBkw2Uvu7u2o3@mail.gmail.com>
	<20100706180951.GR20855@pengutronix.de>
Message-ID: <1278504687.22992.13.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-07-06 at 19:09 +0100, Robert Schwebel wrote:
> On Tue, Jul 06, 2010 at 09:10:58PM +0530, RK Raggit wrote:
> > I rebased the baseport of my cortex-m3 board on your latest
> > linux-2.6-stable git (2.6.33 kernel).
> 
> Is there any off-the-shelf hardware out there which could be used to try
> uCLinux on Cortex-M3?

The one we have in ARM is the Microcontroller Prototyping System and it
has 8MB of RAM:

http://www.arm.com/products/DevTools/mps.html

There may be others but I don't actively work on the Cortex-Mx
processors.

-- 
Catalin
