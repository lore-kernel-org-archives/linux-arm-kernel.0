From: cjb@laptop.org (Chris Ball)
Date: Sun, 26 Jun 2011 23:47:57 -0400
Subject: [PATCH v4 0/4] Extend sdhci-esdhc-imx card_detect and
	write_protect support for mx5
In-Reply-To: <20110627013826.GB21415@S2100-06.ap.freescale.net> (Shawn Guo's
	message of "Mon, 27 Jun 2011 09:38:27 +0800")
References: <1308667311-1855-1-git-send-email-shawn.guo@linaro.org>
	<20110627013826.GB21415@S2100-06.ap.freescale.net>
Message-ID: <m27h88djf6.fsf@bob.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Sun, Jun 26 2011, Shawn Guo wrote: 
>>  arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c     |    3 +-
>>  arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c     |    3 +-
>>  arch/arm/mach-imx/mach-mx25_3ds.c                  |    2 +
>>  arch/arm/mach-imx/mach-pcm043.c                    |    2 +
>>  arch/arm/mach-mx5/board-mx51_babbage.c             |   14 +-
>>  arch/arm/mach-mx5/board-mx53_loco.c                |    4 +
>>  .../plat-mxc/devices/platform-sdhci-esdhc-imx.c    |   12 ++
>>  arch/arm/plat-mxc/include/mach/esdhc.h             |   25 +++-
>>  drivers/mmc/host/sdhci-esdhc-imx.c                 |  140 ++++++++++++--------
>>  drivers/mmc/host/sdhci.c                           |   29 ++++-
>>  10 files changed, 165 insertions(+), 69 deletions(-)
>
> Is the series ready for being merged?  Or is there anything needs
> to be done before you do so?

I'll need to rebase mmc-next onto linux-next before I can merge it,
because the mach-imx/ board files you're modifying do not exist in
Linus' tree.  (I don't mind doing that, but it might be easier if
you had the ARM patches go in via a different tree instead.)

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
