From: srinidhi.kasagar@stericsson.com (Srinidhi Kasagar)
Date: Mon, 6 May 2013 12:43:56 +0530
Subject: [PATCH 54/63] ARM: ux500: Replace ST-E's home-brew DMA
 direction definition with the generic one
In-Reply-To: <1367591569-32197-55-git-send-email-lee.jones@linaro.org>
References: <1367591569-32197-1-git-send-email-lee.jones@linaro.org>
 <1367591569-32197-55-git-send-email-lee.jones@linaro.org>
Message-ID: <20130506071355.GA5552@bnru10>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 03, 2013 at 16:32:40 +0200, Lee Jones wrote:
> STEDMA40_*_TO_* direction definitions are identical in all but name to
> the pre-defined generic DMA_*_TO_* ones. Let's make things easy by not
> duplicating such things.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  arch/arm/mach-ux500/board-mop500-audio.c |   12 ++++++------
>  arch/arm/mach-ux500/board-mop500-sdi.c   |   16 ++++++++--------
>  arch/arm/mach-ux500/board-mop500.c       |   22 +++++++++++-----------
>  arch/arm/mach-ux500/usb.c                |    4 ++--
>  4 files changed, 27 insertions(+), 27 deletions(-)

Hope you have taken care for all other files, because, I see
few more instances in my tree apart from the above files.

Otherwise..

Acked-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>

regards,
srinidhi
