From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 15 Sep 2014 14:02:56 -0700
Subject: [PATCH 0/2] ARM: meson: add clocksource support
In-Reply-To: <1410786691-30302-1-git-send-email-carlo@caione.org>
References: <1410786691-30302-1-git-send-email-carlo@caione.org>
Message-ID: <54175400.6000504@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/15/2014 06:11 AM, Carlo Caione wrote:
> Two patches taken from patchset http://www.spinics.net/lists/devicetree/msg48979.html
> adding support for clocksource and clockevents driver.
>
> Daniel and Thomas,
> if it's fine with you, could you please take these patches in the clocksource
> tree?

Hi Carlo,

just a head up to tell you I saw your patchset. I am right now traveling 
so I will review the patches and pick them up as soon as I come back.

Thanks

   -- Daniel

> Carlo Caione (2):
>    ARM: meson: documentation: add timer documentation
>    ARM: meson6: clocksource: add Meson6 timer support
>
>   .../bindings/timer/amlogic,meson6-timer.txt        |  16 ++
>   drivers/clocksource/Kconfig                        |   3 +
>   drivers/clocksource/Makefile                       |   1 +
>   drivers/clocksource/meson6_timer.c                 | 167 +++++++++++++++++++++
>   4 files changed, 187 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/timer/amlogic,meson6-timer.txt
>   create mode 100644 drivers/clocksource/meson6_timer.c
>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
