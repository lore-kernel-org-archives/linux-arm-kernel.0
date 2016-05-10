From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 10 May 2016 12:22:06 +0200
Subject: [PATCH 0/4] clocksource: Add support for Aspeed timer
In-Reply-To: <1462797169-14512-1-git-send-email-joel@jms.id.au>
References: <1462797169-14512-1-git-send-email-joel@jms.id.au>
Message-ID: <20160510102206.GD14952@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 09, 2016 at 10:02:45PM +0930, Joel Stanley wrote:
> Hello All,
> 
> This adds support for the Aspeed ast2400 and ast2500 families of BMC SoCs to
> the moxart driver.
> 
> I've addressed the feedback from Daniel and spent a bit of time trying to
> ensure the series makes sense.
> 
> I've not included a patch that renames the driver to fttmr010, from Faraday
> Tech, as I wasn't sure if we had consensus. If you would prefer I do so then
> let me know.
> 
> Cheers,
> 
> Joel
> 
> Joel Stanley (4):
>   drivers/clocksouree/moxart: Add kbuild symbol
>   drivers/clocksource/moxart: Refactor enable/disable
>   drivers/clocksource/moxart: Use struct to hold state
>   drivers/clocksource/moxart: Add Aspeed support
> 
>  .../bindings/timer/moxa,moxart-timer.txt           |   4 +-
>  arch/arm/mach-moxart/Kconfig                       |   2 +-
>  drivers/clocksource/Kconfig                        |   9 +
>  drivers/clocksource/Makefile                       |   2 +-
>  drivers/clocksource/moxart_timer.c                 | 191 ++++++++++++++-------
>  5 files changed, 143 insertions(+), 65 deletions(-)

The changes look ok. Could you please reply to patch 2 with a changelog I 
can add.

Thanks.

  -- Daniel
