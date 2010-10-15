From: cjb@laptop.org (Chris Ball)
Date: Fri, 15 Oct 2010 21:18:21 +0100
Subject: [PATCH V5 0/6] SD/MMC driver for MX25/35/51
In-Reply-To: <1287138064-21385-1-git-send-email-w.sang@pengutronix.de>
References: <1287138064-21385-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <20101015201821.GB18898@void.printf.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

On Fri, Oct 15, 2010 at 12:20:58PM +0200, Wolfram Sang wrote:
> Another try. The driver seems to be known by now and used already :) Minor
> fixes only:
> 
> 3/6: Rename a variable (found while working on write-protect-pin support)
> 5/6: Tested the checkpatch fixes
> 6/6: Added Kconfig dependencies
> 
> The series is based on mmc-next as of today and also available at
> 
> 	git://git.pengutronix.de/git/wsa/linux-2.6.git pcm043-mmc
> 
> Thanks,
> 
>    Wolfram
> 
> Wolfram Sang (6):
>   mmc: sdhci-pltfm: Add structure for host-specific data
>   mmc: sdhci-pltfm: move .h-file into apropriate subdir
>   mmc: sdhci: introduce private get_ro
>   mmc: sdhci_pltfm: pass more data on custom init-call
>   mmc: sdhci-of-esdhc: factor out common stuff
>   mmc: sdhci-pltfm: add pltfm-driver for imx35/51

Thanks!  All pushed to mmc-next.

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
