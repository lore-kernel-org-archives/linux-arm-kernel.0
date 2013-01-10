From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 10 Jan 2013 09:43:13 -0700
Subject: [GIT PULL] clockevent driver cleanup for 3.9
In-Reply-To: <20130110124132.GA8680@S2101-09.ap.freescale.net>
References: <20130110124132.GA8680@S2101-09.ap.freescale.net>
Message-ID: <50EEEFA1.9070500@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/10/2013 05:41 AM, Shawn Guo wrote:
> The following changes since commit a49f0d1ea3ec94fc7cf33a7c36a16343b74bd565:

> Shawn Guo (2):
>       ARM: use clockevents_config_and_register() where possible
>       clocksource: use clockevents_config_and_register() where possible

>  arch/arm/mach-tegra/timer.c              |    8 ++------

I'm not sure if there's any issue here, but that file moved to
drivers/clocksource/tegra20_timer.c in a patch in the Tegra tree...
Perhaps the two will merge together just fine; git does recognize the
move as a real move and the diff is tiny. For reference:

ac0fd9e ARM: tegra: move timer.c to drivers/clocksource/
