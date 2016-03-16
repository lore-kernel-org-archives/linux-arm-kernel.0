From: scott.wood@nxp.com (Scott Wood)
Date: Wed, 16 Mar 2016 18:47:34 +0000
Subject: [PATCH] gpio/ls1043a: Correct ls1043a gpio nodes compatible in
 dts file
References: <1457600240-47141-1-git-send-email-Gang.Liu@nxp.com>
 <1457600240-47141-2-git-send-email-Gang.Liu@nxp.com>
Message-ID: <DB5PR0401MB192833673541757889C889C1918A0@DB5PR0401MB1928.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/10/2016 03:06 AM, Liu Gang wrote:
> The ls1043a belongs to the Freescale QorIQ platform, and QorIQ
> platform's gpio nodes should use compatible "fsl,qoriq-gpio".

Why?  I don't see any version register anything else in this block that
could be used to identify potential differences from chip to chip.  At
the least, both compatibles should be present.

Where is the binding for this?

-Scott
