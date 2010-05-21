From: wim@iguana.be (Wim Van Sebroeck)
Date: Fri, 21 May 2010 23:52:11 +0200
Subject: [PATCH 1/6] Driver for the watchdog timer on Freescale IMX2
	(and later) processors.
In-Reply-To: <20100514024915.GE30794@pengutronix.de>
References: <1272528202-24159-1-git-send-email-w.sang@pengutronix.de>
	<1272528202-24159-2-git-send-email-w.sang@pengutronix.de>
	<20100514024915.GE30794@pengutronix.de>
Message-ID: <20100521215211.GV3972@infomag.iguana.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

> Ping. Wim, did you notice this one? Shall the driver go via your tree or via
> the imx-tree along with the resource updates (with your ack)?

I was not to happy with how the close of /dev/watchdog was being done.
So I modified your code so that
* the close is better supported.
* the code is ready for when we change to the generic watchdog api.
* the magic close feature is supported.

I didn't compile test the code. Could you have a look at it? compile it and test it?
Goal is to get this in during this merge window still...

Kind regards,
Wim.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: imx2_wdt.c
Type: text/x-csrc
Size: 10545 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100521/9cb30207/attachment-0001.bin>
