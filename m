From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 5 Mar 2012 13:16:23 -0700 (MST)
Subject: [PATCH] ARM: OMAP2+: omap_device: call all suspend, resume
 callbacks when OMAP_DEVICE_NO_IDLE_ON_SUSPEND is set
In-Reply-To: <877gyzoyyk.fsf@ti.com>
References: <alpine.DEB.2.00.1203031314050.10611@utopia.booyaka.com>
 <877gyzoyyk.fsf@ti.com>
Message-ID: <alpine.DEB.2.00.1203051312390.1430@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 5 Mar 2012, Kevin Hilman wrote:

> Tony, this fix is needed for v3.3.

Of course, I don't have any objection to this patch going into the v3.3-rc 
kernels.  But given that some maintainers seem to be pushing back against 
late -rc patches, this one could probably be delayed to 3.4 if required.  
no_console_suspend is a debugging-only option and bugs involving it are 
unlikely to affect most users.


- Paul
