From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 23 Aug 2016 15:52:03 +0200
Subject: [PATCH v3 1/4] clocksource: timer-atmel-pit: enable mck
In-Reply-To: <1471941845-24813-2-git-send-email-alexandre.belloni@free-electrons.com>
References: <1471941845-24813-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1471941845-24813-2-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <57BC5503.2020605@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/23/2016 10:44 AM, Alexandre Belloni wrote:
> mck is needed to get the PIT working. Explicitly prepare_enable it instead
> of assuming it is enabled.
> 
> This solves an issue where the system is freezing when the ETM/ETB drivers
> are enabled.
> 
> Reported-by: Olivier Schonken <olivier.schonken@gmail.com>
> Reviewed-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---

Applied this one for tip/timers/urgent

Thanks !

  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
