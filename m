From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 11 Jan 2013 21:47:27 +0800
Subject: [GIT PULL] clockevent driver cleanup for 3.9
In-Reply-To: <20130110124132.GA8680@S2101-09.ap.freescale.net>
References: <20130110124132.GA8680@S2101-09.ap.freescale.net>
Message-ID: <20130111134724.GA24429@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

On Thu, Jan 10, 2013 at 08:41:35PM +0800, Shawn Guo wrote:
> The following changes since commit a49f0d1ea3ec94fc7cf33a7c36a16343b74bd565:
> 
>   Linux 3.8-rc1 (2012-12-21 17:19:00 -0800)
> 
> are available in the git repository at:
> 
>   git://git.linaro.org/people/shawnguo/linux-2.6.git tags/clean-clkevt-3.9
> 
> for you to fetch changes up to ab8e73c98749a58c242b187c9799db70cd903157:
> 
>   clocksource: use clockevents_config_and_register() where possible (2013-01-10 20:24:30 +0800)
> 
Please ignore this pull request.  I will refresh it to fix the error [1]
reported by Fengguang.

Shawn

[1] http://thread.gmane.org/gmane.linux.ports.arm.kernel/209152

> ----------------------------------------------------------------
> As John has showed zero interest to collect clock event driver patches,
> I send both patches through arm-soc tree here.
> 
> ----------------------------------------------------------------
> Shawn Guo (2):
>       ARM: use clockevents_config_and_register() where possible
>       clocksource: use clockevents_config_and_register() where possible
