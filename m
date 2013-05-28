From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 28 May 2013 10:48:02 +0530
Subject: [RFC PATCH 1/4] arm: omap: Add phy binding info for musb in plat
 data
In-Reply-To: <1368796954-3499-1-git-send-email-kishon@ti.com>
References: <1368796954-3499-1-git-send-email-kishon@ti.com>
Message-ID: <51A43E0A.8090201@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Friday 17 May 2013 06:52 PM, Kishon Vijay Abraham I wrote:
> In order for controllers to get PHY in case of non dt boot, the phy
> binding information (phy label) should be added in the platform
> data of the controller.

This series would be needed to get MUSB working in OMAP3 boards for 
non-dt boot case. Do you think this is good enough to go in this rc cycle?

Thanks
Kishon
