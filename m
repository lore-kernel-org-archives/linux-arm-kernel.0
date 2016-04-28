From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 28 Apr 2016 17:46:05 +0200
Subject: [GIT PULL] omap fixes for v4.6-rc cycle
In-Reply-To: <20160428145047.GE5995@atomide.com>
References: <20160428145047.GE5995@atomide.com>
Message-ID: <1752100.3oYv3oXt4O@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 28 April 2016 07:50:48 Tony Lindgren wrote:
> The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:
> 
>   Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.6/fixes-rc5-signed
> 
> for you to fetch changes up to 7472931f7f1e9d91f761dce30107ae345b61a5c3:
> 
>   ARM: dts: omap5: fix range of permitted wakeup pinmux registers (2016-04-26 10:16:12 -0700)
> 
> ----------------------------------------------------------------
> Fixes for omaps for v4.6-rc cycle. All dts fixes, mostly
> affecting voltages and pinctrl for various device drivers:
> 
> - Regulator minimum voltage fixes for omap5
> 
> - ISP syscon register offset fix for omap3
> 
> - Fix regulator initial modes for n900
> 
> - Fix omap5 pinctrl wkup instance size

Pulled into fixes, thanks!

	Arnd
