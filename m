From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 20 Oct 2010 13:27:41 +0200
Subject: [PATCH 1/2] mmc: quirk fix for timeout problem
In-Reply-To: <1287566576-1224-1-git-send-email-shawn.gsc@gmail.com>
References: <1287564807-1645-1-git-send-email-shawn.gsc@gmail.com>
	<1287566576-1224-1-git-send-email-shawn.gsc@gmail.com>
Message-ID: <20101020112741.GB10261@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 20, 2010 at 05:22:56PM +0800, Shawn Guo wrote:
> This patch is to fix timeout problem which was seen on babbage.
> Thanks Richard Zhu <r65037@freescale.com> for catching this.
> 
> Signed-off-by: Shawn Guo <shawn.gsc@gmail.com>

NACK. It is still untested if we need that quirk on MX25/35.
Eric wanted to send an updated patch next week.

(And this patch has to go via the mmc-tree IMO)

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 197 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101020/94769a16/attachment.sig>
