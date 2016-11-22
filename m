From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 22 Nov 2016 15:26:30 +0530
Subject: [PATCH 2/3] ARM: davinci: hawk: remove mmc ro pin
In-Reply-To: <20161121161541.27048-3-ahaslam@baylibre.com>
References: <20161121161541.27048-1-ahaslam@baylibre.com>
 <20161121161541.27048-3-ahaslam@baylibre.com>
Message-ID: <5cbc372e-03d6-226b-1468-a254daf603e2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 21 November 2016 09:45 PM, Axel Haslam wrote:
> The hawk board does not have a write protect pin to read the card
> write protect status.
> 
> So remove un-needed platform data declaration for this gpio.
> 
> Signed-off-by: Axel Haslam <ahaslam@baylibre.com>

The schematic I found has the SD_WP pin connected to GPIO3_13.

Thanks,
Sekhar
