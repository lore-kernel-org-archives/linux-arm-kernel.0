From: b32955@freescale.com (Huang Shijie)
Date: Fri, 27 Apr 2012 14:09:53 +0800
Subject: [PATCH 1/2] serial/imx: add DMA support
In-Reply-To: <20120426120043.GH17184@pengutronix.de>
References: <1335436632-29499-1-git-send-email-b32955@freescale.com>
 <1335436632-29499-2-git-send-email-b32955@freescale.com>
 <20120426120043.GH17184@pengutronix.de>
Message-ID: <4F9A3831.1020203@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
>> +/* see the "i.MX61 SDMA Scripts User Manual.doc" for the parameters */
> I can't see how the manual helps here.
sorry, the comment is in the wrong place. it should placed at 
configuring the `slave_config`.
> Please test this patch at least on one more SoC. There should be nothing
> i.MX6 specific in here, the fact that the i.MX6 is mentioned several
> times in the comments make me suspicious.
There are bugs in the UART DMA code in the firmware before the imx6q.  
So we can not test the UART DMA except the imx6q arm2 board.

thanks

Huang Shijie
