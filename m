From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 19 Aug 2015 23:24:44 +0200
Subject: [PATCH v4 4/4] misc: atmel_tclib: get and use slow clock
In-Reply-To: <1439717026-30634-5-git-send-email-alexandre.belloni@free-electrons.com>
References: <1439717026-30634-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1439717026-30634-5-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <55D4F41C.6010109@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/16/2015 11:23 AM, Alexandre Belloni wrote:
> From: Boris Brezillon <boris.brezillon@free-electrons.com>
>
> Commit dca1a4b5ff6e ("clk: at91: keep slow clk enabled to prevent system
> hang") added a workaround for the slow clock as it is not properly handled
> by its users.
>
> Get and use the slow clock as it is necessary for the timer counters.
>
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
