From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 27 Jun 2017 20:27:36 -0300
Subject: [PATCH 1/2] RFC: ARM: dts: imx7d-sdb: remove 100k pull-down on
 USDHCx clock
In-Reply-To: <ed6fda35-089f-f669-b7ed-39454330ec89@boundarydevices.com>
References: <1496857542-32200-1-git-send-email-troy.kisky@boundarydevices.com>
 <20170615033851.GA5902@dragon>
 <AM3PR04MB306DAC69AE94A872373206280C00@AM3PR04MB306.eurprd04.prod.outlook.com>
 <c69c5ffb-1142-74fa-4be4-1112c49ae67c@boundarydevices.com>
 <AM3PR04MB306F527858F26C0F686617880DC0@AM3PR04MB306.eurprd04.prod.outlook.com>
 <26958bc9-7598-74d7-7a4b-91638bf1971c@boundarydevices.com>
 <CAOMZO5CLb_yjGoaSoDnR5tFNjhtTfCDsNdzLnyGkcN2AwYVyuQ@mail.gmail.com>
 <ed6fda35-089f-f669-b7ed-39454330ec89@boundarydevices.com>
Message-ID: <CAOMZO5B48MGrs+_HqOYOgfv6G_1XUJwedVm-P53tW+J747PnNA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 27, 2017 at 5:49 PM, Troy Kisky
<troy.kisky@boundarydevices.com> wrote:

> Hi Fabio !
>
> Yes, but the enable bits(12,13) are clear.
> MX6QDL_PAD_SD2_CLK__SD2_CLK 0x13059
>
> Would turn on 100K pull down.

Yes, you are right. That's the value that some boards use for pulling
down the DATA3 line.

So your patch makes sense in my opinion.
