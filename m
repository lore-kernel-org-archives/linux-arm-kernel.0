From: balbi@ti.com (Felipe Balbi)
Date: Thu, 17 Feb 2011 21:08:09 +0200
Subject: [patch-v2.6.39 6/7] OMAP4430: hwmod data: Adding USBOTG
In-Reply-To: <20110217181849.GV20795@atomide.com>
References: <4D5D44AF.5050805@ti.com> <20110217162000.GP20795@atomide.com>
	<20110217162209.GA13425@legolas.emea.dhcp.ti.com>
	<20110217165953.GR20795@atomide.com> <4D5D5770.9020501@ti.com>
	<20110217171747.GC14574@legolas.emea.dhcp.ti.com>
	<4D5D59E5.6020307@ti.com>
	<20110217173711.GF14574@legolas.emea.dhcp.ti.com>
	<4D5D5F13.2010602@ti.com> <20110217181849.GV20795@atomide.com>
Message-ID: <20110217190809.GM14574@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 17, 2011 at 10:18:49AM -0800, Tony Lindgren wrote:
> * Cousson, Benoit <b-cousson@ti.com> [110217 09:45]:
> > 
> > Done, boot tested, and that does remove the warning about the
> > missing opt clock you had with the previous data.
> > 
> > git://gitorious.org/omap-pm/linux.git for_2.6.39/omap4_hwmod_data
> > 
> > Just let me know if it does break anything else.
> 
> Pulled into omap-for-linus. Also now merged are the devel-hwspinlock
> and devel-mcspi branches.

Ok good. Tomorrow I'll send you a proper pull request for my part, will
leave testusb running over night.

-- 
balbi
