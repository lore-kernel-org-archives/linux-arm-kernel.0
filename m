From: khilman@linaro.org (Kevin Hilman)
Date: Wed, 25 Sep 2013 11:13:22 -0700
Subject: [PATCH 0/5] Allwinner SoCs High Speed Timer support
In-Reply-To: <1380117790-19390-1-git-send-email-maxime.ripard@free-electrons.com>
 (Maxime Ripard's message of "Wed, 25 Sep 2013 17:03:05 +0300")
References: <1380117790-19390-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <87zjr04vnh.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Maxime Ripard <maxime.ripard@free-electrons.com> writes:

> Hi everyone,
>
> Here is a few patches adding support for the High Speed Timers running on the
> Allwinner SoCs.
>
> These timers are 64 bits timers running at a much higher speed than the timers
> used for now on these SoCs, since they are no longer wired to the 24MHz
> oscillator, but to the AHB clock.
>
> This HS timers are actually found in all the supported SoCs but the A10.

hmm, timers not found in the A10...

> However, the A20 and A31 come with 4 of these high speed timers, while the A10s
> and A13 only have two, hence why we introduce two different compatibles.

...but the A10 has 2?

-ECONFUSED

Kevin
