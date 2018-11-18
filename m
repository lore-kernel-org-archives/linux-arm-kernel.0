From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Sun, 18 Nov 2018 02:28:28 +0100
Subject: [PATCH 1/2] clocksource: Demote dbx500 PRCMU clocksource
In-Reply-To: <20181115133203.28567-1-linus.walleij@linaro.org>
References: <20181115133203.28567-1-linus.walleij@linaro.org>
Message-ID: <ef535f28-04e3-d638-22da-7e0b64f367da@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/11/2018 14:32, Linus Walleij wrote:
> Demote the DBx500 PRCMU clocksource to quality 100 and
> mark it as NONSTOP so it will still be used for
> timekeeping across suspend/resume.
> 
> The Nomadik MTU timer which has higher precision will
> be used when the system is up and running, thanks to
> the recent changes properly utilizing the suspend
> clocksources.
> 
> This was discussed back in 2011 when the driver was
> written, but the infrastructure was not available
> upstream to use this timer properly. Now the
> infrastructure is there, so let's finalize the work.
> 
> Cc: Baolin Wang <baolin.wang@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---

Both applied, thanks!


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
