From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 19 May 2014 16:17:22 +0200
Subject: [PATCH] clocksource: qcom: Implement read_current_timer for udelay
In-Reply-To: <1400022060-30118-1-git-send-email-sboyd@codeaurora.org>
References: <1400022060-30118-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <537A1272.1020206@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/14/2014 01:01 AM, Stephen Boyd wrote:
> Setup the same timer used as the clocksource to be used as the
> read_current_timer implementation. This allows us to support a
> stable udelay implementation on MSMs where it's possible for the
> CPUs to scale speeds independently of one another.
>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Applied to my tree for 3.16

Thanks
   -- Daniel

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
