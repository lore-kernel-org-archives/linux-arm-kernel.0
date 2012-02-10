From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 10 Feb 2012 11:38:22 +0100
Subject: [PATCH][V3] ux500 : decouple/recouple gic from the PRCMU
In-Reply-To: <1328869344-31332-1-git-send-email-daniel.lezcano@linaro.org>
References: <1328869344-31332-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <4F34F39E.2080109@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/10/2012 11:22 AM, Daniel Lezcano wrote:
> This patch allows to decouple and recouple the gic from the PRCMU.
> This is needed to put the A9 core in retention mode with the cpuidle
> driver.
>
> Signed-off-by: Daniel Lezcano<daniel.lezcano@linaro.org>
> ---

Linus,

I think I addressed all the concerns, is it possible to merge this patch ?

Thanks in advance.
-- Daniel


-- 
  <http://www.linaro.org/>  Linaro.org ? Open source software for ARM SoCs

Follow Linaro:<http://www.facebook.com/pages/Linaro>  Facebook |
<http://twitter.com/#!/linaroorg>  Twitter |
<http://www.linaro.org/linaro-blog/>  Blog
