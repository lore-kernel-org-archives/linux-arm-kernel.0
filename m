From: tony@atomide.com (Tony Lindgren)
Date: Tue, 9 Oct 2012 14:47:36 -0700
Subject: [PATCH] ARM: OMAP: move old debug-devices.c and debug-leds.c
 to be OMAP2+ only for now
In-Reply-To: <alpine.DEB.2.00.1210092008370.5736@utopia.booyaka.com>
References: <alpine.DEB.2.00.1210080145080.5736@utopia.booyaka.com>
 <20121008221333.GZ13011@atomide.com>
 <alpine.DEB.2.00.1210092008370.5736@utopia.booyaka.com>
Message-ID: <20121009214736.GH12552@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [121009 13:12]:
> 
> OK if you want to leave it there, it's fine with me.  Looks like it 
> should go into drivers/ at some point though?

Yes it should be just a regular device driver
eventually at some point. But no rush, let's first
get the dependencies between device drivers and core
omap code removed by removing the remaining mach and
plat includes.

Regards,

Tony
