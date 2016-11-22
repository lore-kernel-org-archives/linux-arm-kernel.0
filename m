From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 22 Nov 2016 16:07:31 +0530
Subject: [RESEND PATCH 2/3] ARM: davinci: hawk: Remove vbus and over
 current gpios
In-Reply-To: <20161121165349.29128-3-ahaslam@baylibre.com>
References: <20161121165349.29128-1-ahaslam@baylibre.com>
 <20161121165349.29128-3-ahaslam@baylibre.com>
Message-ID: <cf13650b-1880-7dda-e249-9763bfe3032a@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 21 November 2016 10:23 PM, Axel Haslam wrote:
> The hawk board VBUS is fixed to a 5v source, and the over
> current pin is actually not connected to the SoC.
> 
> Do not reseve these gpios for OHCI as they are not related
> to usb.
> 
> Signed-off-by: Axel Haslam <ahaslam@baylibre.com>

As discussed over the MMC/SD patches, this patch should be based off the
hawkboard schematic, not the LCDK schematic.

Thanks,
Sekhar
