From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 16 Jul 2013 17:01:23 +0200
Subject: [PATCH v8] ARM: clocksource: add support for MOXA ART SoCs
In-Reply-To: <1373985880-23469-1-git-send-email-jonas.jensen@gmail.com>
References: <1373024773-24574-1-git-send-email-jonas.jensen@gmail.com>
 <1373985880-23469-1-git-send-email-jonas.jensen@gmail.com>
Message-ID: <51E56043.1010509@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/16/2013 04:44 PM, Jonas Jensen wrote:
> This patch adds an clocksource driver for the main timer(s)
> found on MOXA ART SoCs.
> 
> Signed-off-by: Jonas Jensen <jonas.jensen@gmail.com>
> ---

Ok, I will ask you two more things before taking your patch. I missed
them at the previous review, sorry for asking a new version.

1. could you elaborate the patch log: as it is a new driver, a nice
description of the timer hardware would be valuable for people willing
to understand the code (eg. some specificities of the driver).

2. fix the alignment below

Thanks
  -- Daniel

[ ... ]

> +
> +#define TIMER_CR		0x30
> +#define TIMER_INTR_STATE	0x34
> +#define TIMER_INTR_MASK		0x38


[ ... ]

-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
