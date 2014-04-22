From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 22 Apr 2014 13:57:59 +0200
Subject: [PATCH v3 0/2] ARM: sunxi: Add A31 High Speed Timer Support
In-Reply-To: <1397725606-18000-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1397725606-18000-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <53565947.3020503@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/17/2014 11:06 AM, Maxime Ripard wrote:
> Hi everyone,
>
> This patchset enables support for the High Speed Timer IP found in the
> Allwinner A31 SoCs.
>
> These timers are asserted in reset, and are not associated with any
> struct device, so we also add a small helper to the reset framework
> along the way to be able to retrieve the reset controller from the
> device tree directly.
>
> Thanks,
> Maxime
>
> Changes from v2:
>    - Rebased on top of 3.15-rc1
>
> Changes from v1:
>    - Rebased on top of 3.14-rc1 and reset/for_3.15
>
> Maxime Ripard (2):
>    clocksource: sun5i: Add support for reset controller
>    ARM: sun6i: a31: Add support for the High Speed Timers
>
>   .../devicetree/bindings/timer/allwinner,sun5i-a13-hstimer.txt |  4 ++++
>   arch/arm/boot/dts/sun6i-a31.dtsi                              | 11 +++++++++++
>   drivers/clocksource/timer-sun5i.c                             |  6 ++++++
>   3 files changed, 21 insertions(+)

Applied for 3.16

Thanks

   -- Daniel


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
