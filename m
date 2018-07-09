From: tony@atomide.com (Tony Lindgren)
Date: Mon, 9 Jul 2018 03:50:36 -0700
Subject: [PATCH v2] Add DT support for Octavo Systems OSD3358-SM-RED
 based on TI AM335x
In-Reply-To: <20180709104641.GB99251@atomide.com>
References: <20180706200051.1115-1-neeraj.dantu@octavosystems.com>
 <20180709104641.GB99251@atomide.com>
Message-ID: <20180709105036.GC99251@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [180709 10:49]:
> * Neeraj Dantu <dantuguf14105@gmail.com> [180706 13:04]:
> > OSD3358-SM-RED is a dev board for OSD335x System-in-Package(SiP) devices from
> > Octavo Systems.
> 
> Applying into omap-for-v4.19/dt thanks.

Hmm dropping patch as it fails to build with make dtbs:

Error: arch/arm/boot/dts/am335x-osd3358-sm-red.dts:146.20-21 syntax error
FATAL ERROR: Unable to parse input tree

Can you please check against current Linux next and make sure it
builds and boots and then repost one more time?

Thanks,

Tony
