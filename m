From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 8 May 2018 03:40:24 +0200
Subject: [PATCH v3 1/3] clocksource: timer-ti-dm: remove the early
 platform driver registration
In-Reply-To: <20180504132731.14574-2-brgl@bgdev.pl>
References: <20180504132731.14574-1-brgl@bgdev.pl>
 <20180504132731.14574-2-brgl@bgdev.pl>
Message-ID: <20180508014024.GE19313@mai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 04, 2018 at 03:27:29PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> This driver is no longer used as an early platform driver. Remove the
> registration macro.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 

 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
