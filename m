From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 22 Nov 2016 17:36:02 +0530
Subject: [PATCH] ARM: dts: da850-lcdk: fix mmc card detect polarity
In-Reply-To: <20161121154155.16985-1-ahaslam@baylibre.com>
References: <20161121154155.16985-1-ahaslam@baylibre.com>
Message-ID: <ee55e39e-36ff-7807-5366-214aa9b01e3f@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 21 November 2016 09:11 PM, Axel Haslam wrote:
> The polarity of the card detect pin is inverted.
> 
> Change it to reflect the right polarity for the board
> which is ACTIVE_LOW.
> 
> Signed-off-by: Axel Haslam <ahaslam@baylibre.com>

Applied to v4.10/dt

Thanks,
Sekhar
