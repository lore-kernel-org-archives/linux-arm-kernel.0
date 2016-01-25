From: tony@atomide.com (Tony Lindgren)
Date: Mon, 25 Jan 2016 10:08:30 -0800
Subject: [PATCH repost] arm: plat-omap: Add PWM dmtimer platform data
 quirks
In-Reply-To: <1453479351-21825-1-git-send-email-narmstrong@baylibre.com>
References: <20151130183707.GK2517@atomide.com>
 <1453479351-21825-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <20160125180829.GV19432@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Neil Armstrong <narmstrong@baylibre.com> [160122 08:16]:
> In order to set the currently platform dependent dmtimer
> functions pointers as platform data for the pwm-omap-dmtimer
> platform driver, add it to plat-omap auxdata_lookup table.
> 
> Suggested-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  arch/arm/mach-omap2/pdata-quirks.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> Tony, Thierry,
> 
> The previous patches are now upstream, here is a repost of the patch re-tested
> against mainline.
> 
> Ref: http://lkml.kernel.org/r/56374592.4060201 at baylibre.com 
> Patchset: http://lkml.kernel.org/r/5620ED2C.1090107 at baylibre.com

OK great. I'll add this into omap-for-v4.5/fixes so we get the
PWM driver working.

Regards,

Tony
