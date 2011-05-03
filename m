From: tony@atomide.com (Tony Lindgren)
Date: Tue, 3 May 2011 03:44:01 -0700
Subject: [PATCH v5 4/8] arm/dt: probe for platforms via the device tree
In-Reply-To: <20110502215537.GE10097@ponder.secretlab.ca>
References: <20110429070135.12522.35745.stgit@ponder>
	<20110429071548.12522.56929.stgit@ponder>
	<20110502151542.GG2092@atomide.com>
	<BANLkTikue6jMUcQMv9GD4cZ=o5EEW7QDqQ@mail.gmail.com>
	<20110502163951.GC9243@atomide.com>
	<20110502215537.GE10097@ponder.secretlab.ca>
Message-ID: <20110503104401.GQ2092@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Grant Likely <grant.likely@secretlab.ca> [110502 14:52]:
> On Mon, May 02, 2011 at 07:39:54PM +0300, Tony Lindgren wrote:
> > 
> > The cmdline is something that bootloaders typically allow to configure,
> > while the other ATAGs are static and should be in the .dts file.
> 
> Once the libfdt code is pulled into to manipulate the command line,
> it becomes trivial to parse the rest of the atags too, so this
> probably won't make much difference (unless work is done to preparse
> the devicetree and provide to the zimage wrapper a direct offset to
> the cmdline buffer in the dtb, but that gets hairy and I really don't
> want to go down that path).
 
OK, makes sense.
  
> > > Adding a default command line to the .dts file instead of using
> > > CONFIG_CMDLINE_FORCE also works.
> > 
> > But that requires carrying extra patches for something that should
> > be user configured.. So not so nice for distros.
> 
> Right, so this is only a stop-gap solution.  I'll add this to the list
> of topics to discuss in the device tree session at Linaro at UDS next
> week.

Thanks

Tony
