From: B29396@freescale.com (Dong Aisheng-B29396)
Date: Wed, 14 Dec 2011 08:49:36 +0000
Subject: [PATCH 5/5] ASoC: mxs: correct 'direction' of
 device_prep_dma_cyclic
In-Reply-To: <1323848866-19768-1-git-send-email-shawn.guo@linaro.org>
References: <1323791286-29574-1-git-send-email-shawn.guo@linaro.org>
 <1323848866-19768-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <7FE21149F4667147B645348EC605788503F3AE@039-SN2MPN1-013.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-kernel-owner at vger.kernel.org [mailto:linux-kernel-
> owner at vger.kernel.org] On Behalf Of Shawn Guo
> Sent: Wednesday, December 14, 2011 3:48 PM
> To: Liam Girdwood; Mark Brown
> Cc: Dong Aisheng; alsa-devel at alsa-project.org; linux-
> kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org; Shawn Guo
> Subject: [PATCH 5/5] ASoC: mxs: correct 'direction' of
> device_prep_dma_cyclic
> 
> The commit 49920bc (dmaengine: add new enum dma_transfer_direction)
> changes the type of parameter 'direction' of device_prep_dma_cyclic from
> dma_data_direction to dma_transfer_direction.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  sound/soc/mxs/mxs-pcm.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
Acked-by: Dong Aisheng <dong.aisheng@linaro.org>

Regards
Dong Aisheng
