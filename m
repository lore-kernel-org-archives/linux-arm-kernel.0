From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 18 Jul 2011 22:38:16 +0200
Subject: [PATCH v3 00/10] ARM: mxs: add audio support
In-Reply-To: <1310731780-1645-1-git-send-email-b29396@freescale.com>
References: <1310731780-1645-1-git-send-email-b29396@freescale.com>
Message-ID: <20110718203816.GA9457@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 15, 2011 at 08:09:30PM +0800, Dong Aisheng wrote:

> This patch series is to add audio support based on saif for mxs platform.
> The driver only supports playback currently.
> For capturing, due to hardware limitation that we have to use two saif
> instances to implement full duplex (playback & recording), we need to
> figure out a good design to fit in ASoC as the following work.

So, since the codec problems seem to be resolved now (and they were luckily
really just codec-problems):

For the ASoC-patches (1-4):

Tested-by: Wolfram Sang <w.sang@pengutronix.de>

For the mach-mxs-Patches (5-9, 10 is already picked up), assuming patch 6 will
lose the DIGCTRL-handling:

Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>

I think this series is good for 3.1. Now we just need the mxs-dma bugfix on
top, but that's a different patch...

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110718/48388356/attachment.sig>
