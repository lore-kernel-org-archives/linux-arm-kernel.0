From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 18 Mar 2018 09:54:42 -0300
Subject: [PATCH 1/2] ARM: dts: pfuze3000: update sw1a/vldo4 voltage range
In-Reply-To: <AM3PR04MB1315E1C3071C0BD2E7169968F5D50@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1521269828-8874-1-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5BzE46Dm24++j+xVA4KGFnpsopGfJ97h7sFGOAxVa19=g@mail.gmail.com>
 <AM3PR04MB1315E1C3071C0BD2E7169968F5D50@AM3PR04MB1315.eurprd04.prod.outlook.com>
Message-ID: <CAOMZO5AFJk_Q5CYrV0s+hLmORHosWujRSGjwf9smyAQc4nmJ+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 17, 2018 at 11:23 PM, Anson Huang <anson.huang@nxp.com> wrote:

> I thought the max value here means the capability of regulator itself, like the internal

No it is not.

Please check Documentation/devicetree/bindings/regulator/regulator.txt:

"- regulator-max-microvolt: largest voltage consumers may set"
