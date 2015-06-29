From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 29 Jun 2015 12:20:01 +0200
Subject: [PATCH] clocksource: imx: define clocksource for mx27
In-Reply-To: <1435439504-406-1-git-send-email-tremyfr@gmail.com>
References: <1435439504-406-1-git-send-email-tremyfr@gmail.com>
Message-ID: <55911BD1.7040302@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/27/2015 11:11 PM, Philippe Reynes wrote:
> The clocksource imx27 wasn't defined in timer-imx-gpt.c,
> so the kernel no longer boot on imx27. Just define
> clocksource imx27 as an imx21.
>
> Signed-off-by: Philippe Reynes <tremyfr@gmail.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
