From: olof@lixom.net (Olof Johansson)
Date: Fri, 14 Jun 2013 18:14:13 -0700
Subject: [GIT PULL 5/5] ARM: tegra: defconfig updates
In-Reply-To: <1371227838-18764-6-git-send-email-swarren@wwwdotorg.org>
References: <1371227838-18764-1-git-send-email-swarren@wwwdotorg.org>
 <1371227838-18764-6-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20130615011413.GS18124@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 14, 2013 at 10:37:18AM -0600, Stephen Warren wrote:
> Enable some new features:
> * The Tegra114 SPI controller, for Dalmore's SPI flash.
> * Set all the GPIO leds triggers to their "if you don't know, say X"
>   value, so there are some useful triggers for the gpio-leds support.
> * TPS65090 charger, for Dalmore.
> * ASoC RT5640 machine driver, for audio on Beaver and Dalmore.
> 
> Also, rebuild tegra_defconfig on top of linux-next. This should make it
> easier to create future defconfig patches, without extraneous diffs.
> 
> This branch is based on v3.10-rc3, in order not to conflict with a
> defconfig change first included there.


Pulled. Note that the last two lines aren't really valuable as part of the tag
text (but as part of the pull request they are)


-Olof
