From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 9 Apr 2018 19:37:45 +0800
Subject: [PATCH RESEND v6 0/6] provide power off support for iMX6 with
 external PMIC
In-Reply-To: <20180305102524.5905-1-o.rempel@pengutronix.de>
References: <20180305102524.5905-1-o.rempel@pengutronix.de>
Message-ID: <20180409113744.GA14582@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 05, 2018 at 11:25:17AM +0100, Oleksij Rempel wrote:
> This patch series is providing power off support for Freescale/NXP iMX6 based
> boards with external power management integrated circuit (PMIC).
> As a first step the PMIC is configured to turn off the system if the
> standby pin is asserted. On second step we assert the standby pin.
> For this reason we need to use pm_power_off_prepare.
> 
> Usage of stnadby pin for power off is described in official iMX6
> documentation.
> 
> 2018.03.05:
> As this patch set touches multiple subsystems I think it would make
> sense for Shawn Guo to take the all patch set.
> The only part which didn't receive an ACK is regulator stuff. So I would
> hope that Mark Brown can ACK it.

Besides regulator changes, I did not see an ACK on kernel/reboot.c
either.

Shawn
