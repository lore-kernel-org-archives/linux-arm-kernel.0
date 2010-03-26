From: w.sang@pengutronix.de (Wolfram Sang)
Date: Fri, 26 Mar 2010 15:47:51 +0100
Subject: [PATCH] netdev/fec.c: add phylib supporting to enable carrier
	detection
In-Reply-To: <1269597052-10104-1-git-send-email-bryan.wu@canonical.com>
References: <1269597052-10104-1-git-send-email-bryan.wu@canonical.com>
Message-ID: <20100326144751.GA22937@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 26, 2010 at 05:50:52PM +0800, Bryan Wu wrote:
> BugLink: http://bugs.launchpad.net/bugs/457878
> 
>  - removed old MII phy control code
>  - add phylib supporting
>  - add ethtool interface to make user space NetworkManager works
> 
> Tested on Freescale i.MX51 Babbage board.
> 
> This patch is based on a patch from Frederic Rodo <fred.rodo@gmail.com>
> 
> Cc: Frederic Rodo <fred.rodo@gmail.com>
> Signed-off-by: Bryan Wu <bryan.wu@canonical.com>

Great, will test it soon.

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 197 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100326/18d3fea2/attachment.sig>
