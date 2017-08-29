From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 29 Aug 2017 11:14:11 +0200
Subject: [PATCH] clocksource: Delete an error message for a failed memory
 allocation in bcm2835_timer_init()
In-Reply-To: <1907fa5f-e1c3-a2dd-99e0-f06150086351@users.sourceforge.net>
References: <1907fa5f-e1c3-a2dd-99e0-f06150086351@users.sourceforge.net>
Message-ID: <a292aac5-b98e-6f84-8ef4-e9a00c582ba8@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/08/2017 21:46, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 27 Aug 2017 21:38:13 +0200
> 
> Omit an extra message for a memory allocation failure in this function.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---

I have applied it.

Thanks.

  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
