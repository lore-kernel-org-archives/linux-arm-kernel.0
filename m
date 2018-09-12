From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 12 Sep 2018 09:11:19 +0800
Subject: [PATCH v9 6/6] ARM: dts: imx6: RIoTboard provide standby on
 power off option
In-Reply-To: <20180802103425.3053-7-o.rempel@pengutronix.de>
References: <20180802103425.3053-1-o.rempel@pengutronix.de>
 <20180802103425.3053-7-o.rempel@pengutronix.de>
Message-ID: <20180912011118.GC28469@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 02, 2018 at 12:34:25PM +0200, Oleksij Rempel wrote:
> This board, as well as some other boards with i.MX6 and a PMIC, uses a
> "PMIC_STBY_REQ" line to notify the PMIC about a state change.
> The PMIC is programmed for a specific state change before triggering the
> line.
> In this case, PMIC_STBY_REQ can be used for stand by, sleep
> and power off modes.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Applied, thanks.
