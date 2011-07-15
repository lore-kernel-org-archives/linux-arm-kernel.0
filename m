From: w.sang@pengutronix.de (Wolfram Sang)
Date: Fri, 15 Jul 2011 22:39:01 +0200
Subject: [PATCH v3 00/10] ARM: mxs: add audio support
In-Reply-To: <1310731780-1645-1-git-send-email-b29396@freescale.com>
References: <1310731780-1645-1-git-send-email-b29396@freescale.com>
Message-ID: <20110715203901.GB24047@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 15, 2011 at 08:09:30PM +0800, Dong Aisheng wrote:
> This patch series is to add audio support based on saif for mxs platform.
> The driver only supports playback currently.
> For capturing, due to hardware limitation that we have to use two saif
> instances to implement full duplex (playback & recording), we need to
> figure out a good design to fit in ASoC as the following work.
> 
> In addition, we simply just support master mode since saif tx can
> only work as a master due to hw limitation(rx can work in both
> master & slave mode).
> 
> Code is written based on the branch imx-for-3.1 in sascha's tree
> http://git.pengutronix.de/git/imx/linux-2.6.git

Thanks! Branch can be found here:

git://git.pengutronix.de/git/wsa/linux-2.6.git mxs-audio-v3

Will test tomorrow!

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110715/eaac185c/attachment.sig>
