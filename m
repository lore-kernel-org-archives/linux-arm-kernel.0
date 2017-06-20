From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 19 Jun 2017 17:19:36 -0700
Subject: [PATCH v5 6/6] ARM: dts: imx6: RIoTboard provide standby on
 power off option
In-Reply-To: <20170619050245.2632-7-o.rempel@pengutronix.de>
References: <20170619050245.2632-1-o.rempel@pengutronix.de>
 <20170619050245.2632-7-o.rempel@pengutronix.de>
Message-ID: <20170620001936.GU20170@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/19, Oleksij Rempel wrote:
> This board, as well as some other boards with i.MX6 and a PMIC, uses a
> "MPIC_STBY_REQ" line to notify the PMIC about a state change.

PMIC_STBY_REQ?

> The PMIC is programmed for a specific state change before triggering the
> line.
> In this case, PMIC_STBY_REQ can be used for stand by, sleep

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
