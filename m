From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 23 Jun 2017 21:29:51 +0200
Subject: [PATCH v3] clocksource/drivers/tcb_clksrc: make IO endian agnostic
In-Reply-To: <20170623150331.16435-1-alexandre.belloni@free-electrons.com>
References: <20170623150331.16435-1-alexandre.belloni@free-electrons.com>
Message-ID: <654c51b1-aa68-dd54-6534-a1bb58db33ce@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/06/2017 17:03, Alexandre Belloni wrote:
> Now that AVR32 is gone, we can use the proper IO accessors that are
> correctly handling endianness.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> ---
> Changes in v3:
>  - rebased on top of tip/timers/core
>  - Added collected acks
> 

Applied, thanks.

  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
