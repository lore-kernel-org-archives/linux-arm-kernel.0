From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 22 Nov 2016 15:23:56 +0530
Subject: [PATCH 1/3] ARM: davinci: hawk: fix mmc card detect gpio
In-Reply-To: <20161121161541.27048-2-ahaslam@baylibre.com>
References: <20161121161541.27048-1-ahaslam@baylibre.com>
 <20161121161541.27048-2-ahaslam@baylibre.com>
Message-ID: <8ced1194-4c68-7385-1594-0983855e7c89@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 21 November 2016 09:45 PM, Axel Haslam wrote:
> The card detect gpio on the hawk board is gpio4_0 and not gpio3_12
> 
> Signed-off-by: Axel Haslam <ahaslam@baylibre.com>

The LCDK and HawkBoard are different boards. The HawkBoard schematic
from eLinux.org page is broken, but looking for it on the net, I found
one and the MMC/SD CD pin in that schematic is indeed connected to GPIO3_12.

So I believe the original code is correct.

Thanks,
Sekhar
