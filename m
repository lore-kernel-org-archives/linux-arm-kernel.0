From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 26 Aug 2015 09:37:40 +0200
Subject: [PATCH 0/5] add GPT timer support for mt8173
In-Reply-To: <1436779969-18610-1-git-send-email-yingjoe.chen@mediatek.com>
References: <1436779969-18610-1-git-send-email-yingjoe.chen@mediatek.com>
Message-ID: <55DD6CC4.6010708@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/13/2015 11:32 AM, Yingjoe Chen wrote:
> This series add GPT timer support for mt8173. This is based on v4.2-rc1
> and Matthias' next branch (for dts parts).
>
> The first 2 patches comes from 'Add SMP bringup support for mt65xx socs'
> series [1]. I decide to move these 2 patches to this series, since it
> is more relevent here. They are changed based on Matthias' and Daniel's
> comments.
>
> [1] http://lists.infradead.org/pipermail/linux-mediatek/2015-May/000714.html
>
> Daniel Kurtz (1):
>    arm64: dts: mt8173: add timer node
>
> Yingjoe Chen (4):
>    clocksource: mediatek: do not enable GPT_CLK_EVT when setup
>    clocksource: mediatek: Use GPT as sched clock source
>    arm64: mediatek: enable MTK_TIMER
>    clk: mediatek: add 13mhz clock for MT8173
>
>   arch/arm64/Kconfig                       |  1 +
>   arch/arm64/boot/dts/mediatek/mt8173.dtsi |  9 +++++++++
>   drivers/clk/mediatek/clk-mt8173.c        |  5 +++++
>   drivers/clocksource/mtk_timer.c          | 26 ++++++++++++++++++++------
>   include/dt-bindings/clock/mt8173-clk.h   |  3 ++-
>   5 files changed, 37 insertions(+), 7 deletions(-)

Who will take this patchset ? I can take the patch 2 if needed.


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
