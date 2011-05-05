From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 5 May 2011 21:46:01 +0200
Subject: ARM, AF_PACKET: caching problems on Marvell Kirkwood
In-Reply-To: <20110505141107.GC30443@orbit.nwl.cc>
References: <20110408130643.GA8730@orbit.nwl.cc>
	<20110505141107.GC30443@orbit.nwl.cc>
Message-ID: <20110505194601.GA10565@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 05, 2011 at 04:11:07PM +0200, Phil Sutter wrote:
> Hi,
> 
> Hasn't anyone experienced this bug but me? Can anyone reproduce the
> described behaviour on his Kirkwood-based (or even generic ARM) machine?
> I am still not sure if this is a problem of just my CPU or common
> amongst Kirkwood/VIPT/ARM machines.

Hi Phil

I can reproduce it on a Kirkwood:

[    0.000000] CPU: Feroceon 88FR131 [56251311] revision 1 (ARMv5TE), cr=00053977

     Andrew
