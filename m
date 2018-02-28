From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 28 Feb 2018 14:35:49 +0800
Subject: [PATCH] ARM: dts: imx6dl-icore-rqs: Fix invalid PHY address
 assignment for ethernet
In-Reply-To: <1519747143-3036-1-git-send-email-mayhs11saini@gmail.com>
References: <1519747143-3036-1-git-send-email-mayhs11saini@gmail.com>
Message-ID: <20180228063548.GJ3217@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 27, 2018 at 09:29:03PM +0530, shyam saini wrote:
> From: Shyam Saini <shyam@amarulasolutions.com>
> 
> Add "reg" property for ethernet to fix this issue.
> 
> Errors in boot logs:
> mdio_bus 2188000.ethernet-1:
> /soc/aips-bus at 02100000/ethernet at 02188000/mdio/ethernet-phy
> has invalid PHY address
> 
> mdio_bus 2188000.ethernet-1: scan phy ethernet-phy at address 0
> mdio_bus 2188000.ethernet-1: scan phy ethernet-phy at address 1
> mdio_bus 2188000.ethernet-1: scan phy ethernet-phy at address 2
> mdio_bus 2188000.ethernet-1: scan phy ethernet-phy at address 3
> 
> Reported-by: Shyam Saini <shyam@amarulasolutions.com>
> Suggested-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Shyam Saini <shyam@amarulasolutions.com>

Applied, thanks.
