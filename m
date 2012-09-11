From: sameo@linux.intel.com (Samuel Ortiz)
Date: Tue, 11 Sep 2012 15:00:41 +0200
Subject: [PATCH] mfd: ab8500: Make ab8500_irq_get_virq() static
In-Reply-To: <1345460017-404-1-git-send-email-lee.jones@linaro.org>
References: <1345460017-404-1-git-send-email-lee.jones@linaro.org>
Message-ID: <20120911130041.GS3647@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Mon, Aug 20, 2012 at 11:53:36AM +0100, Lee Jones wrote:
> MFD core now takes care of  HWIRQ <-> VIRQ mapping, so the helper
> ab8500_irq_get_virq() is no longer used by ab8500 subordinate devices
> to obtain a Linux wide Virtual IRQ. The AB8500 IRQ controller still
> uses it internally though, so we'll just hide it from the rest of the
> world by making it static instead.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/mfd/ab8500-core.c         |   33 ++++++++++++++++-----------------
>  include/linux/mfd/abx500/ab8500.h |    2 --
>  2 files changed, 16 insertions(+), 19 deletions(-)
Patch applied, thanks.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
