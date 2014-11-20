From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Nov 2014 13:43:10 +0100
Subject: [GIT PULL] at91: drivers for 3.19 #1
In-Reply-To: <1415976210-3665-1-git-send-email-nicolas.ferre@atmel.com>
References: <1415976210-3665-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <201411201343.11011.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 14 November 2014, Nicolas Ferre wrote:
> Arnd, Olof, Kevin,
> 
> This is a pull-request about AT91-related drivers that are easier to take via
> arm-soc.
> 
> There is a little merge conflict with the "cleanup" branch because of removal
> of at91sam9g45 and at91sam9rl legacy code. The resolution is pretty simple but
> you can have a look at the resolution example here:
> https://git.kernel.org/cgit/linux/kernel/git/nferre/linux-at91.git/log/?h=at91-next
> 
> Thanks, best regards,
> 
> The following changes since commit cac7f2429872d3733dc3f9915857b1691da2eb2f:
> 
>   Linux 3.18-rc2 (2014-10-26 16:48:41 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git tags/at91-drivers
> 
> for you to fetch changes up to 2c91e61dc97cce57ffd9dd654a6ee284e1f45a1f:
> 
>   rtc: at91sam9: add DT bindings documentation (2014-11-13 16:08:48 +0100)
> 
> ----------------------------------------------------------------
> First batch of drivers for 3.19:
> It is only about a not so recent driver for old platforms: RTT as RTC driver:
> - RTT as RTC driver enhancements and machine specific include files removal
> - RTT as RTC driver conversion to device tree

Pulled into next/drivers, thanks!

	Arnd
