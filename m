From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 7 Dec 2017 16:34:38 +0100
Subject: [PATCH net-next v2 1/8] net: phy: meson-gxl: check phy_write
 return value
In-Reply-To: <20171207142715.32578-2-jbrunet@baylibre.com>
References: <20171207142715.32578-1-jbrunet@baylibre.com>
 <20171207142715.32578-2-jbrunet@baylibre.com>
Message-ID: <20171207153438.GF24750@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 07, 2017 at 03:27:08PM +0100, Jerome Brunet wrote:
> Always check phy_write return values. Better to be safe than sorry
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
