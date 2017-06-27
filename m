From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 27 Jun 2017 17:30:09 -0300
Subject: [PATCH 1/2] RFC: ARM: dts: imx7d-sdb: remove 100k pull-down on
 USDHCx clock
In-Reply-To: <26958bc9-7598-74d7-7a4b-91638bf1971c@boundarydevices.com>
References: <1496857542-32200-1-git-send-email-troy.kisky@boundarydevices.com>
 <20170615033851.GA5902@dragon>
 <AM3PR04MB306DAC69AE94A872373206280C00@AM3PR04MB306.eurprd04.prod.outlook.com>
 <c69c5ffb-1142-74fa-4be4-1112c49ae67c@boundarydevices.com>
 <AM3PR04MB306F527858F26C0F686617880DC0@AM3PR04MB306.eurprd04.prod.outlook.com>
 <26958bc9-7598-74d7-7a4b-91638bf1971c@boundarydevices.com>
Message-ID: <CAOMZO5CLb_yjGoaSoDnR5tFNjhtTfCDsNdzLnyGkcN2AwYVyuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Troy,

On Tue, Jun 27, 2017 at 5:22 PM, Troy Kisky
<troy.kisky@boundarydevices.com> wrote:

> And why mx6q does not want to do the same ?

On imx6qdl-sabresd.dtsi we have:

MX6QDL_PAD_SD2_CLK__SD2_CLK 0x10059

PUS field is at 00, which means 100k pull down.
