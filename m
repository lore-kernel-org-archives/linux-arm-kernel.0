From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 10 Mar 2017 06:16:43 +0100
Subject: [PATCH] ARM: imx25: set default phy_type and dr_mode for usbotg
 port
In-Reply-To: <20170216211858.8563-1-u.kleine-koenig@pengutronix.de>
References: <20170216211858.8563-1-u.kleine-koenig@pengutronix.de>
Message-ID: <20170310051642.GB5848@x250>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 16, 2017 at 10:18:58PM +0100, Uwe Kleine-K?nig wrote:
> All currently supported i.MX25-based machines use phy_type = "utmi" and
> dr_mode = "otg".  So this seems to be a sensible default.
> 
> This also doesn't hurt out-of-tree machines because up to now they had
> to specify these two properties in the machine.dts which still takes
> precedence by just overwriting the defaults added here.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Applied, thanks.
