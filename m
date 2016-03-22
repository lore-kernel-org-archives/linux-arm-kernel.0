From: scott.wood@nxp.com (Scott Wood)
Date: Tue, 22 Mar 2016 16:00:19 +0000
Subject: [PATCH] gpio/ls1043a: Correct ls1043a gpio nodes compatible in
 dts file
References: <1457600240-47141-1-git-send-email-Gang.Liu@nxp.com>
 <1457600240-47141-2-git-send-email-Gang.Liu@nxp.com>
 <DB5PR0401MB192833673541757889C889C1918A0@DB5PR0401MB1928.eurprd04.prod.outlook.com>
 <DB4PR04MB26636780AB3453AE0D3E218828B0@DB4PR04MB266.eurprd04.prod.outlook.com>
 <DB5PR0401MB19283736845DCFD5F4186729918C0@DB5PR0401MB1928.eurprd04.prod.outlook.com>
 <DB4PR04MB2660ED371AE3599B6EC8F8E82800@DB4PR04MB266.eurprd04.prod.outlook.com>
Message-ID: <DB5PR0401MB19284B4AAA63BD31A605AC7691800@DB5PR0401MB1928.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/22/2016 09:03 AM, Gang Liu wrote:
> Hi, Scott,
> 
> I think you mean that GPIO node needs two compatibles, one for general GPIO IP block ("fsl,qoriq-gpio")
> and another for chip-specific ("fsl,ls1043a-gpio").
> The driver can just include general GPIO IP block compatible, and if there is a errata for ls1043 GPIO, the
> chip-specific compatible can be used to fix the errata, right?

Yes.

> If it's right, do you think the "fsl,ls1043a-gpio" and "fsl,qoriq-gpio" are ok for our Layerscape platforms?

Yes.

-Scott
