From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 11 Aug 2015 15:27:11 +0200
Subject: [PATCH v3 2/4] clocksource: atmel-st: get and use slow clock
In-Reply-To: <1439285884-16051-3-git-send-email-alexandre.belloni@free-electrons.com>
References: <1439285884-16051-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1439285884-16051-3-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <55C9F82F.1000400@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/11/2015 11:38 AM, Alexandre Belloni wrote:
> The current slow clock rate is hardcoded. Properly get the slow clock
> and use its rate.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
