From: tony@atomide.com (Tony Lindgren)
Date: Thu, 17 Feb 2011 08:21:57 -0800
Subject: [patch-v2.6.39 6/7] OMAP4430: hwmod data: Adding USBOTG
In-Reply-To: <20110217152648.GO22356@legolas.emea.dhcp.ti.com>
References: <1297946466-9565-1-git-send-email-balbi@ti.com>
	<1297946466-9565-7-git-send-email-balbi@ti.com>
	<4D5D25F9.8030907@ti.com>
	<20110217151527.GL22356@legolas.emea.dhcp.ti.com>
	<20110217151804.GM22356@legolas.emea.dhcp.ti.com>
	<4D5D3D0B.8090106@ti.com>
	<20110217152648.GO22356@legolas.emea.dhcp.ti.com>
Message-ID: <20110217162157.GQ20795@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <balbi@ti.com> [110217 07:25]:
> 
> Tony, what do you prefer ? Do we clear out the dependency, or you queue
> all the patches I have manually ??

Let's apply Benoit's hwmod data patches first into omap-for-linus,
then rebasing other patches to that should be trivial and I can
pull in your patches.

Regards,

Tony
