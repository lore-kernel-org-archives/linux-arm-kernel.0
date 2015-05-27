From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 27 May 2015 14:50:27 +0200
Subject: [PATCH v3 12/12] ARM: imx: move timer driver into
 drivers/clocksource
In-Reply-To: <1432530849-12312-1-git-send-email-shawn.guo@linaro.org>
References: <1432308599-28643-13-git-send-email-shawn.guo@linaro.org>
 <1432530849-12312-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <5565BD93.50600@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/25/2015 07:14 AM, Shawn Guo wrote:
> After the cleanup on imx timer driver, now it's ready to be moved into
> drivers/clocksource/.  Let's do it.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

I don't see the Kconfig change.



-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
