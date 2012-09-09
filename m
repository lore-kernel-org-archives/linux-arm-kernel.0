From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 9 Sep 2012 11:39:17 -0400
Subject: sata_mv hangs up while probing on LaCie Kirkwood boards
In-Reply-To: <20120908180945.GB3451@lunn.ch>
References: <20120908165050.GA31897@kw.sim.vm.gnt>
 <20120908180945.GB3451@lunn.ch>
Message-ID: <20120909153917.GI19437@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 08, 2012 at 08:09:45PM +0200, Andrew Lunn wrote:
> On Sat, Sep 08, 2012 at 06:50:51PM +0200, Simon Guinot wrote:
> > Hi,
> > 
> > I have noticed recently that Linux 3.6.0-rc* hangs up while booting on
> > LaCie Kirkwood-based boards. I have only tested on Network Space v2 and
> > 2Big Network v2 boards.
> 
> Yes, I do hope the fix for this hits -rc sometime soon.
> 
> http://www.spinics.net/lists/arm-kernel/msg189311.html
> 
> Add "coherent_pool=1M" to the kernel parameters.

This just went in last night, v3.6-rc5:

cb01b63 ARM: Kirkwood: increase atomic coherent pool size

hth,

Jason.
