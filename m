From: tony@atomide.com (Tony Lindgren)
Date: Thu, 17 Dec 2015 09:48:44 -0800
Subject: [PATCH v02 0/2] ARM: DTS: am33xx/am437x: Use the new eDMA bindings
In-Reply-To: <1450359217-3038-1-git-send-email-peter.ujfalusi@ti.com>
References: <1450359217-3038-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20151217174844.GT23396@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [151217 05:33]:
> Hi,
> 
> Changes since v1:
> - Updated to use the non 16bit arrays [1]
> - send the two patch as a series
> 
> [1]
> As it has been discussed earlier:
> https://www.mail-archive.com/linux-omap at vger.kernel.org/msg122117.html
> 
> the DT bindings has been changes compared to what we had in 4.4-rc1: the arrays
> now don't have the 16bit type.
> The changes are now merged to mainline and Vinod provided us a branch:
> 
> git://git.infradead.org/users/vkoul/slave-dma.git fix/edma
> 
> Which is based on 4.4-rc1 and only contains the two patch for changing the eDMA
> bindings.

Great, I'll merge the fix/edma also into omap-for-v4.5/dt and apply
your two patches.

Regards,

Tony
