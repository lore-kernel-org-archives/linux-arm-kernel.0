From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 19 May 2014 16:18:45 +0200
Subject: [PATCH] clocksource:sirf: remove the hardcode for the clk of
 timers
In-Reply-To: <1399289404-10247-1-git-send-email-21cnbao@gmail.com>
References: <1399289404-10247-1-git-send-email-21cnbao@gmail.com>
Message-ID: <537A12C5.60304@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/05/2014 01:30 PM, Barry Song wrote:
> From: Zhiwu Song <Zhiwu.Song@csr.com>
>
> Nobody want to know the connection between io clk and timer clk,
> so exposing this information to timer module is not reasonable.
> this patch moves to define the timers' clk in dt.
>
> Signed-off-by: Zhiwu Song <Zhiwu.Song@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>

[fixed the subject format]

Applied to my tree for 3.16

Thanks
   -- Daniel


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
