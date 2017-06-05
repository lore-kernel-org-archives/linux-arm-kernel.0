From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 5 Jun 2017 16:19:22 +0200
Subject: [PATCH] ARM: dts: imx: Fix Ethernet PHY reset polarity
In-Reply-To: <1496597475-1361-1-git-send-email-festevam@gmail.com>
References: <1496597475-1361-1-git-send-email-festevam@gmail.com>
Message-ID: <20170605141922.GA11772@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 04, 2017 at 02:31:15PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> The FEC driver ignores the GPIO polarity from 'phy-reset-gpios' and
> considers that the Ethernet PHY is active low, unless the
> property 'phy-reset-active-high' is present.
> 
> Fix the device tree description by explicitly passing the 
> 'GPIO_ACTIVE_LOW' flag to the 'phy-reset-gpios' property.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
