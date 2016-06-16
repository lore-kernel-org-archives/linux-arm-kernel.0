From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 16 Jun 2016 15:29:59 +0200
Subject: [PATCH v3 1/2] clocksource: Add Oxford Semiconductor RPS Dual
 Timer
In-Reply-To: <201606152311.i4cc0bJ4%fengguang.wu@intel.com>
References: <201606152311.i4cc0bJ4%fengguang.wu@intel.com>
Message-ID: <5762A9D7.4070208@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/15/2016 05:51 PM, kbuild test robot wrote:
> Hi,
>
> [auto build test ERROR on tip/timers/core]
> [also build test ERROR on v4.7-rc3 next-20160615]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

You should add in the Kconfig:

+depends on GENERIC_CLOCKSOURCE



-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
