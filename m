From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 7 Dec 2017 16:34:03 +0100
Subject: [PATCH net-next v2 5/8] net: phy: meson-gxl: detect LPA corruption
In-Reply-To: <20171207142715.32578-6-jbrunet@baylibre.com>
References: <20171207142715.32578-1-jbrunet@baylibre.com>
 <20171207142715.32578-6-jbrunet@baylibre.com>
Message-ID: <20171207153403.GE24750@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 07, 2017 at 03:27:12PM +0100, Jerome Brunet wrote:
> The purpose of this change is to fix the incorrect detection of the link
> partner (LP) advertised capabilities which sometimes happens with this PHY
> (roughly 1 time in a dozen)

Hi Jerome

Since this is a real fix, please send it alone. Base it on net, not
net-next.  David will then get it applied to stable, so it will be
backported.

Thanks
	Andrew
