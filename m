From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 7 Dec 2017 16:54:21 +0100
Subject: [PATCH net-next v2 7/8] net: phy: meson-gxl: add interrupt support
In-Reply-To: <20171207142715.32578-8-jbrunet@baylibre.com>
References: <20171207142715.32578-1-jbrunet@baylibre.com>
 <20171207142715.32578-8-jbrunet@baylibre.com>
Message-ID: <20171207155421.GJ24750@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 07, 2017 at 03:27:14PM +0100, Jerome Brunet wrote:
> Enable interrupt support in meson-gxl PHY driver

Hi Jerome

Is it possible to implement did_interrupt()? That allows for shared
interrupts. It does however work fine without it, so long as the
interrupt is not shared.

	  Thanks
		Andrew
