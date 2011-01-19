From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Wed, 19 Jan 2011 14:08:19 -0200
Subject: [PATCH] usb: gadget/fsl_mxc_udc: Detect the CPU type in run-time
In-Reply-To: <4D37050E.6010009@eukrea.com>
References: <1295451164-3363-1-git-send-email-fabio.estevam@freescale.com>
	<4D37050E.6010009@eukrea.com>
Message-ID: <4D370C73.6010707@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/19/2011 1:36 PM, Eric B?nard wrote:
...

> are you sure this compiles when MX35 is not selected ?

You?re right. Doesn?t build when I tried a mx5 kernel.

We can?t use this approach then.

Thanks,

Fabio Estevam
 
