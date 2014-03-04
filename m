From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 4 Mar 2014 14:59:49 +0530
Subject: [PATCH 03/12] phy: ti-pipe3: cleanup clock handling
In-Reply-To: <1393859254-10937-4-git-send-email-rogerq@ti.com>
References: <1393859254-10937-1-git-send-email-rogerq@ti.com>
 <1393859254-10937-4-git-send-email-rogerq@ti.com>
Message-ID: <53159D0D.2040009@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Monday 03 March 2014 08:37 PM, Roger Quadros wrote:
> As this driver is no longer USB specific, use generic clock names.
> - Fix PLL_SD_SHIFT from 9 to 10
> - As optclk and wkupclk may not be always required, don't bail out
> if they aren't available.

I think here too we face the same problem as for PHY. What if a 
particular platform needs a clock but is not available. I don't want 
this to be blocking though.

Thanks
Kishon
