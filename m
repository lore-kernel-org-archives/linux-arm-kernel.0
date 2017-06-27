From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 27 Jun 2017 20:49:22 -0300
Subject: [PATCH 1/2] RFC: ARM: dts: imx7d-sdb: remove 100k pull-down on
 USDHCx clock
In-Reply-To: <AM3PR04MB306F527858F26C0F686617880DC0@AM3PR04MB306.eurprd04.prod.outlook.com>
References: <1496857542-32200-1-git-send-email-troy.kisky@boundarydevices.com>
 <20170615033851.GA5902@dragon>
 <AM3PR04MB306DAC69AE94A872373206280C00@AM3PR04MB306.eurprd04.prod.outlook.com>
 <c69c5ffb-1142-74fa-4be4-1112c49ae67c@boundarydevices.com>
 <AM3PR04MB306F527858F26C0F686617880DC0@AM3PR04MB306.eurprd04.prod.outlook.com>
Message-ID: <CAOMZO5CFqV5+=s3eh-OO4R_RXi1+tMcnS84FWbL+bK8r9voBJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dong,

On Tue, Jun 27, 2017 at 2:32 AM, A.s. Dong <aisheng.dong@nxp.com> wrote:

> Not quite understand your point.
> We would like to pull down the clk signal in default state,
> But due to the board pull-down resistor is DNP (not exist),
> That's why we use internal pull down function instead.

Looking at the SD1_CLK line in the mx7d-sdb schematics rev d there is
no pull-down DNP resistor.

The DNP element in this line is capacitor C197.
