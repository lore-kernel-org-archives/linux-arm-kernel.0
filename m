From: timur@tabi.org (Timur Tabi)
Date: Sun, 23 Jun 2013 12:49:17 -0500
Subject: [PATCH v9 01/10] ASoC: imx-pcm-dma: DT support
In-Reply-To: <1371734429-6081-2-git-send-email-mpa@pengutronix.de>
References: <1371734429-6081-1-git-send-email-mpa@pengutronix.de>
 <1371734429-6081-2-git-send-email-mpa@pengutronix.de>
Message-ID: <51C7351D.9080004@tabi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Markus Pargmann wrote:
> This patch removes the NO_DT flag. The pdev pointer may have a proper
> of_node with the dmas property, so we can use it to request DMA
> channels.
>
> Signed-off-by: Markus Pargmann<mpa@pengutronix.de>
> Tested-by: Shawn Guo<shawn.guo@linaro.org>
> ---

I won't have access to functioning hardware for another month or two, so I 
can't test to see if this patchset breaks PowerPC, but at least it does 
compile.  I'm a little worried that the DMA changes won't actually run on 
PowerPC, but I can't test that now.

So for the time being:

Acked-by: Timur Tabi <timur@tabi.org>

-- 
Timur Tabi
