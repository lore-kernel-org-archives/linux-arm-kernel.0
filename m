From: tony@atomide.com (Tony Lindgren)
Date: Thu, 17 Feb 2011 10:18:49 -0800
Subject: [patch-v2.6.39 6/7] OMAP4430: hwmod data: Adding USBOTG
In-Reply-To: <4D5D5F13.2010602@ti.com>
References: <20110217152648.GO22356@legolas.emea.dhcp.ti.com>
	<4D5D44AF.5050805@ti.com> <20110217162000.GP20795@atomide.com>
	<20110217162209.GA13425@legolas.emea.dhcp.ti.com>
	<20110217165953.GR20795@atomide.com> <4D5D5770.9020501@ti.com>
	<20110217171747.GC14574@legolas.emea.dhcp.ti.com>
	<4D5D59E5.6020307@ti.com>
	<20110217173711.GF14574@legolas.emea.dhcp.ti.com>
	<4D5D5F13.2010602@ti.com>
Message-ID: <20110217181849.GV20795@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Cousson, Benoit <b-cousson@ti.com> [110217 09:45]:
> 
> Done, boot tested, and that does remove the warning about the
> missing opt clock you had with the previous data.
> 
> git://gitorious.org/omap-pm/linux.git for_2.6.39/omap4_hwmod_data
> 
> Just let me know if it does break anything else.

Pulled into omap-for-linus. Also now merged are the devel-hwspinlock
and devel-mcspi branches.

Tony
