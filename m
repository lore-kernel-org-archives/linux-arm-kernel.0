From: broonie@kernel.org (Mark Brown)
Date: Tue, 7 Jan 2014 15:38:26 +0000
Subject: [PATCH 06/11] ASoC: ux500_pcm: Expect different saved DMA data
 when obtaining from DAI store
In-Reply-To: <1387468508-12286-7-git-send-email-lee.jones@linaro.org>
References: <1387468508-12286-1-git-send-email-lee.jones@linaro.org>
 <1387468508-12286-7-git-send-email-lee.jones@linaro.org>
Message-ID: <20140107153826.GO31886@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 19, 2013 at 03:55:03PM +0000, Lee Jones wrote:
> In preparation for full Device Tree enablement we must differentiate
> between the two varying ways DMA data can be held in the DAI store. If
> we're booting with Device Tree the provided 'snd_dmaengine_dai_dma_data'
> data structure shall be used, whereas in order to avoid breaking legacy
> platform data we also need to be able to translate DMA data stored using
> the UX500 specific 'ux500_msp_dma_params' method.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140107/5207a24b/attachment.sig>
