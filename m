From: l.fu@pengutronix.de (Luotao Fu)
Date: Thu, 28 Jan 2010 12:16:57 +0100
Subject: LPC32XX architecture files (updated)
In-Reply-To: <1264643011-17390-1-git-send-email-wellsk40@gmail.com>
References: <1264643011-17390-1-git-send-email-wellsk40@gmail.com>
Message-ID: <4B617229.4090903@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

wellsk40 at gmail.com wrote:
> The initial LCP32xx arch files are in these patches. Changes from
> yesterdays posting:
> 
> gpiolib.c updated from user review comments, thanks!
> 
> Files all send via git send-email now, thanks for pointing me in
> the right direction and sorry about the wraps. (if gmail wasn't
> available, I'd be stuck!)
> 
> These have been checked with checkpatch.
> 
> thanks,
> Kevin Wells
> NXP Semiconductors
> 
thx for the patches. I applied them together with the nxp patches by RMK on the
linus master tree. (since it otherwise won't compile, as you've mentioned
earlier). It compiles so far. For convenience I put this onto our public git server

git://git.pengutronix.de/git/lfu/linux-lfu lpc32xx_wells

cheers
Luotao Fu
-- 
Pengutronix e.K.                           | Dipl.-Ing. Luotao Fu        |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
