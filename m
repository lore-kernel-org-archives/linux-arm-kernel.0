From: khilman@linaro.org (Kevin Hilman)
Date: Thu, 22 Aug 2013 11:39:21 -0700
Subject: [GIT PULL] at91: device tree update for 3.12 #1
In-Reply-To: <1377097510-14090-1-git-send-email-nicolas.ferre@atmel.com>
 (Nicolas Ferre's message of "Wed, 21 Aug 2013 17:05:10 +0200")
References: <1377097510-14090-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <87txihr2na.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolas Ferre <nicolas.ferre@atmel.com> writes:

> Arnd, Olof, Kevin,
>
> Here is the first pull request about DT on AT91 for 3.12.
> It is based on 3.11-rc5 as I saw that the branch is coming from this tag on
> your side.
>
> Thanks, best regards,
>
> The following changes since commit d4e4ab86bcba5a72779c43dc1459f71fea3d89c8:
>
>   Linux 3.11-rc5 (2013-08-11 18:04:20 -0700)
>
> are available in the git repository at:
>
>   git://github.com/at91linux/linux-at91.git tags/at91-dt
>
> for you to fetch changes up to 90d01929ad38259596371c78df8a9ecf37a7f815:
>
>   ARM: at91/dt: sam9x5ek: add sound configuration (2013-08-21 13:33:44 +0200)
>
> ----------------------------------------------------------------
> More DT work on AT91:
> - sound support for at91sam9x5 family
> - at91sam9n12: touch button, i2c and gpio-keys
> - adding missing pinctrl-names to MCI on at91rm9200 and at91sam9260/9g20
> - adding ARM Performance Monitor Unit (PMU) on sama5d3

Pulled into next/dt.

Kevin
