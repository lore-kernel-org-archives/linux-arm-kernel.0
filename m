From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 11 Aug 2015 15:27:45 +0200
Subject: [PATCH v3 3/4] clocksource: tcb_clksrc: fix setup_clkevents error
 path
In-Reply-To: <1439285884-16051-4-git-send-email-alexandre.belloni@free-electrons.com>
References: <1439285884-16051-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1439285884-16051-4-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <55C9F851.1000204@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/11/2015 11:38 AM, Alexandre Belloni wrote:
> From: Boris Brezillon <boris.brezillon@free-electrons.com>
>
> t2_clk is already disabled before request_irq(), it must not be disabled
> again.
>
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
