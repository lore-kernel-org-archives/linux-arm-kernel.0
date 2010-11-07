From: cjb@laptop.org (Chris Ball)
Date: Sun, 7 Nov 2010 22:51:37 +0000
Subject: [PATCH 1/2] sdhci-esdhc-imx: fix timeout on i.MX's sdhci
In-Reply-To: <1287791842-706-1-git-send-email-eric@eukrea.com>
References: <20101022231203.GA6502@void.printf.net>
	<1287791842-706-1-git-send-email-eric@eukrea.com>
Message-ID: <20101107225137.GE13608@void.printf.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

On Sat, Oct 23, 2010 at 01:57:21AM +0200, Eric B?nard wrote:
> this patch fix timeout problems on i.MX's sdhci as suggested by
> Richard Zhu.
> 
> Tested on :
> - i.MX257 : not needed
> - i.MX357 : needed
> - i.MX515 : needed
> 
> more details can be found here :
> http://lists.infradead.org/pipermail/linux-arm-kernel/2010-October/029748.html
> 
> Signed-off-by: Eric B?nard <eric@eukrea.com>
> Tested-by: Shawn Guo <shawn.gsc@gmail.com>
> Acked-by: Wolfram Sang <w.sang@pengutronix.de>

Thanks, I've pushed and queued these two patches for 2.6.37.

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
