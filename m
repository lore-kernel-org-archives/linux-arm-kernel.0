From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 12 Sep 2018 09:10:34 +0800
Subject: [PATCH v9 2/6] ARM: imx6: register pm_power_off handler if
 "fsl,pmic-stby-poweroff" is set
In-Reply-To: <20180802103425.3053-3-o.rempel@pengutronix.de>
References: <20180802103425.3053-1-o.rempel@pengutronix.de>
 <20180802103425.3053-3-o.rempel@pengutronix.de>
Message-ID: <20180912011033.GB28469@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 02, 2018 at 12:34:21PM +0200, Oleksij Rempel wrote:
> One of the Freescale recommended sequences for power off with external
> PMIC is the following:
> ...
> 3.  SoC is programming PMIC for power off when standby is asserted.
> 4.  In CCM STOP mode, Standby is asserted, PMIC gates SoC supplies.
> 
> See:
> http://www.nxp.com/assets/documents/data/en/reference-manuals/IMX6DQRM.pdf
> page 5083
> 
> This patch implements step 4. of this sequence.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Applied, thanks.
