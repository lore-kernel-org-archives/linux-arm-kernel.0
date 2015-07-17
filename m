From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Fri, 17 Jul 2015 23:56:35 +0200
Subject: [PATCH 1/5] clocksource: mediatek: do not enable GPT_CLK_EVT when
 setup
In-Reply-To: <1436779969-18610-2-git-send-email-yingjoe.chen@mediatek.com>
References: <1436779969-18610-1-git-send-email-yingjoe.chen@mediatek.com>
 <1436779969-18610-2-git-send-email-yingjoe.chen@mediatek.com>
Message-ID: <287437450.ZlyYtovZRG@ubix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, July 13, 2015 05:32:45 PM Yingjoe Chen wrote:
> Spurious mtk timer interrupt is noticed at boot and cause kernel
> crash. It seems if GPT is enabled, it will latch irq status even
> when its IRQ is disabled. When irq is enabled afterward, we see
> spurious interrupt.
> Change init flow to only enable GPT_CLK_SRC at mtk_timer_init.
> 
> Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
> ---

Acked-by: Matthias Brugger <matthias.bgg@gmail.com>
