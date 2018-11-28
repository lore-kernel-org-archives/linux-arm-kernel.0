From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 28 Nov 2018 16:24:07 +0800
Subject: [PATCH] ARM: dts: imx6sll-evk: use WDOG_B pin reset
In-Reply-To: <1542855018-30217-1-git-send-email-Anson.Huang@nxp.com>
References: <1542855018-30217-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <20181128082405.GK20643@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 22, 2018 at 02:55:45AM +0000, Anson Huang wrote:
> i.MX6SLL EVK board has WDOG_B pin connected to the PMIC;
> 
> Add the WDOG_B pinctrl entry and 'fsl,ext-reset-output'
> property to wdog node to let watchdog trigger a system
> POR reset via the PMIC.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
