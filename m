From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 03 Aug 2015 17:51:35 +0200
Subject: [PATCH v2 4/9] clocksource: mediatek: Use GPT as sched clock
 source
In-Reply-To: <1431763110-443-5-git-send-email-yingjoe.chen@mediatek.com>
References: <1431763110-443-1-git-send-email-yingjoe.chen@mediatek.com>
 <1431763110-443-5-git-send-email-yingjoe.chen@mediatek.com>
Message-ID: <55BF8E07.7090308@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/16/2015 09:58 AM, Yingjoe Chen wrote:
> When cpu is in deep idle, arch timer will stop counting. Setup GPT as
> sched clock source so it can keep counting in idle.
>
> Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
