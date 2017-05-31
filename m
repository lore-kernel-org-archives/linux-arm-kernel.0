From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 31 May 2017 10:24:57 +0200
Subject: [PATCH 6/7] clocksource: Rename CLKSRC_OF to TIMER_OF
In-Reply-To: <1495879129-28109-6-git-send-email-daniel.lezcano@linaro.org>
References: <1495879129-28109-1-git-send-email-daniel.lezcano@linaro.org>
 <1495879129-28109-6-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <CAJKOXPc54UKCBr_8jqUE+5_YHbwEWOv=YRz0zR-ymaXaiGUHyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 27, 2017 at 11:58 AM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> The config option name is now renamed to 'TIMER_OF' for consistency with
> the CLOCKSOURCE_OF_DECLARE => TIMER_OF_DECLARE change.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  arch/arm/Kconfig                        | 10 +++---
>  arch/arm/mach-bcm/Kconfig               |  2 +-
>  arch/arm/mach-clps711x/Kconfig          |  2 +-
>  arch/arm/mach-imx/epit.c                |  2 +-
>  arch/arm/mach-s3c24xx/Kconfig           |  2 +-
>  arch/arm/mach-s3c64xx/Kconfig           |  2 +-
>  arch/arm64/Kconfig.platforms            |  4 +--
>  arch/h8300/Kconfig                      |  2 +-
>  arch/microblaze/Kconfig                 |  2 +-
>  arch/mips/ralink/Kconfig                |  2 +-
>  arch/nios2/Kconfig                      |  2 +-
>  arch/sh/boards/Kconfig                  |  2 +-
>  drivers/clocksource/Kconfig             | 60 ++++++++++++++++-----------------
>  drivers/clocksource/Makefile            |  2 +-
>  drivers/clocksource/clksrc-probe.c      | 55 ------------------------------
>  drivers/clocksource/clps711x-timer.c    |  2 +-
>  drivers/clocksource/samsung_pwm_timer.c |  2 +-

For s3c24xx, s3c64xx and samsung_pwm_timer:
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
