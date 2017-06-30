From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Fri, 30 Jun 2017 01:10:44 +0000
Subject: [PATCH 2/2] ASoC: audio-graph-card: add widgets and routing for
 external amplifier support
In-Reply-To: <1498742798-3128-3-git-send-email-shawnguo@kernel.org>
References: <1498742798-3128-1-git-send-email-shawnguo@kernel.org>
 <1498742798-3128-3-git-send-email-shawnguo@kernel.org>
Message-ID: <87vanei8uc.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Shawn

> From: Shawn Guo <shawn.guo@linaro.org>
> 
> It's very common that audio card has a machine level amplifier which is
> controlled by GPIO.  The patch adds DAPM widgets and routing support
> into audio-graph-card driver, and creates an output driver widget with
> event to control the amplifier via GPIO.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---

Thank you for your patch.
I think patch adds 3 features (= widget/routing/gpio) in 1 patch.
widget/routing features are already supported in -utils,
so, break down this patch into "widget/routing" patch, and "gpio" patch
is easy to understand, IMO.
Not a big deal though

Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Best regards
---
Kuninori Morimoto
