From: peter.chen@nxp.com (Peter Chen)
Date: Wed, 13 Jan 2016 02:20:40 +0000
Subject: [PATCH v2 1/1] USB: core: let USB device know device node
In-Reply-To: <2243040.bqZF27Q8z8@diplodocus>
References: <1452594758-23417-1-git-send-email-peter.chen@freescale.com>
 <2243040.bqZF27Q8z8@diplodocus>
Message-ID: <DB5PR04MB1446B433117AAEE25EE9254D8BCB0@DB5PR04MB1446.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 
> 
> On Tuesday, January 12, 2016 06:32:38 PM Peter Chen wrote:
> > descirbe these at device tree.
> s/descirbe/describe/
> 
> ...by the way
> I no longer see any reference to a reset GPIO.
> Did that get moved to u-boot, and if so is that posted somewhere?
>

The DT maintainer does not accept my proposal change for device tree.
And they (and Alan) seems to agree with moving it to bootloader. 

http://www.spinics.net/lists/linux-usb/msg134788.html

Peter
