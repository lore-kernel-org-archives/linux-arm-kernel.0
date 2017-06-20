From: ore@pengutronix.de (Oleksij Rempel)
Date: Tue, 20 Jun 2017 06:02:06 +0200
Subject: [PATCH v5 6/6] ARM: dts: imx6: RIoTboard provide standby on power
 off option
In-Reply-To: <20170620001936.GU20170@codeaurora.org>
References: <20170619050245.2632-1-o.rempel@pengutronix.de>
 <20170619050245.2632-7-o.rempel@pengutronix.de>
 <20170620001936.GU20170@codeaurora.org>
Message-ID: <e1cd6a98-479c-b188-1417-5ead29a89273@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 20.06.2017 02:19, Stephen Boyd wrote:
> On 06/19, Oleksij Rempel wrote:
>> This board, as well as some other boards with i.MX6 and a PMIC, uses a
>> "MPIC_STBY_REQ" line to notify the PMIC about a state change.
>
> PMIC_STBY_REQ?

Ok, thanks.
