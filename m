From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 7 Apr 2017 20:21:23 +0800
Subject: [PATCH v2 4/4] ARM: dts: imx6qp-sabresd: Set reg_arm regulator
 supply
In-Reply-To: <f032759a6df750e504d040dfc80d834046c4c540.1491324640.git.leonard.crestez@nxp.com>
References: <cover.1491324640.git.leonard.crestez@nxp.com>
 <f032759a6df750e504d040dfc80d834046c4c540.1491324640.git.leonard.crestez@nxp.com>
Message-ID: <20170407122121.GD16503@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 04, 2017 at 08:04:14PM +0300, Leonard Crestez wrote:
> On imx6qp-sabresd LDO_ARM is connected to a different PMIC output than
> the other imx6qdl-sabresd boards.
> 
> Setting cpu0 arm-supply to sw2_reg is wrong, this must have mistakenly
> slipped out of the vendor tree where this is are used for LDO bypass.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

Applied, thanks.
