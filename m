From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 23 May 2014 23:27:51 +0200
Subject: [GIT PULL] at91: DT for 3.16 at91-dt3 #3
In-Reply-To: <1400775895-31183-1-git-send-email-nicolas.ferre@atmel.com>
References: <1400775895-31183-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <201405232327.52312.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 22 May 2014, Nicolas Ferre wrote:
> Another AT91 DT pull-request for 3.16. This one is the conversion of two more
> SoC to Common Clock Framework (aka CCF). I identified it as a "DT" pull-request
> but it modifies slightly a couple of files in mach-at91 (use of a configuration
> option).

Four done, four more to go? Nice progress!

> This pull-request depends on:
> - the fixes that I already sent for 3.15 and that are present in the recent
>   3.15-rc6 tag.
> - the at91-cleanup tag that you integrated in your arm-soc/next/soc branch.
> So, as suggested by Arnd on IRC, I merged both of them to act as the base
> before adding the material for this pull-request.
> 
> About the clock nodes that should be grouped in a "clocks" container or not,
> while waiting for a clear statement by the DT maintainers, I kept the clocks
> nodes as they had been written by Boris.
> As proposed by Olof, I plan to send you a comprehensive patch that fixes this
> when Mark gives his point of view.

Ok. I've merged it into next/dt now.

	Arnd
