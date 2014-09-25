From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 25 Sep 2014 18:20:37 +0200
Subject: [GIT PULL] Allwinner drivers additions for 3.18
In-Reply-To: <20140920202855.GA20329@lukather>
References: <20140920202855.GA20329@lukather>
Message-ID: <201409251820.38087.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 20 September 2014, Maxime Ripard wrote:
> Hi,
> 
> Please pull the following changes for the next merge window.
> 

Pulled into next/drivers. The patches look good, but please note that the RTC
subsystem does have a maintainer and mailing list. You should really keep
them in the loop for the reviews *and* the submission.

	Arnd

> The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:
> 
>   Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-drivers-for-3.18
> 
> for you to fetch changes up to 64a1925c00706253aa887431fc45f96db48aa727:
> 
>   rtc: sunxi: Depend on platforms sun4i/sun7i that actually have the rtc (2014-09-19 12:39:30 +0200)
> 
> ----------------------------------------------------------------
> Allwinner drivers additions for 3.18
> 
> Nothing major, just handling the RTC driver changes needed for the A31/A23.
> 
> ----------------------------------------------------------------
> Chen-Yu Tsai (2):
>       rtc: sun6i: Add sun6i RTC driver
>       rtc: sunxi: Depend on platforms sun4i/sun7i that actually have the rtc
> 
>  .../devicetree/bindings/rtc/sun6i-rtc.txt          |  17 +
>  drivers/rtc/Kconfig                                |   9 +-
>  drivers/rtc/Makefile                               |   1 +
>  drivers/rtc/rtc-sun6i.c                            | 447 +++++++++++++++++++++
>  4 files changed, 473 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/rtc/sun6i-rtc.txt
>  create mode 100644 drivers/rtc/rtc-sun6i.c
> 
> -- 
> Maxime Ripard, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
> 
