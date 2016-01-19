From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 19 Jan 2016 09:49:49 +0100
Subject: [PATCH] clocksource: atmel-st: use return value from
 clk_prepare_enable()
In-Reply-To: <1453145698-23661-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1453145698-23661-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <569DF8AD.5040704@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/18/2016 08:34 PM, Alexandre Belloni wrote:
> ret is used to detect an error but it was not properly updated after
> calling clk_prepare_enable() thus it made it impossible to detect an error
> when enabling the slow clock.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---

Applied thanks !

   -- Daniel


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
