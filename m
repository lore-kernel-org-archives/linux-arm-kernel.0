From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 04 Dec 2014 19:10:16 +0100
Subject: [GIT PULL] at91: defconfig for 3.19 #1 (bis)
In-Reply-To: <1417711082-27680-1-git-send-email-nicolas.ferre@atmel.com>
References: <3905790.gg6cCb9BU6@wuerfel>
 <1417711082-27680-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <5326460.tA0RksQ2IP@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 04 December 2014 17:38:02 Nicolas Ferre wrote:
> Arnd, Olof, Kevin,
> 
> This is the updated version of the 3.19 defconfig pull-request. It is now based
> on 3.18-rc1 per Arnd's request.
> 
> Here is a pull-request for updating the AT91 defconfig files. Note that we only
> have two now that the per-SoC defconfigs are gone.
> 
> Thanks, bye,
> 
> The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:
> 
>   Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git tags/at91-defconfig
> 
> for you to fetch changes up to 51756cbd407b760858a16341eb37ee527be178fd:
> 
>   ARM: at91/defconfig: add DM9000 to at91_dt (2014-12-04 17:32:01 +0100)
> 
> ----------------------------------------------------------------
> First batch of defconfigs for AT91 / 3.19:
> - use NEON for all C-A5, neon code handles the !NEON case
> - add new XDMA driver
> - add some useful drivers as we only have a single defconfig for all
>   AT91SAM9/RM9200
> 

Pulled into next/defconfig, thanks!

	Arnd
