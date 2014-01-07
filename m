From: broonie@kernel.org (Mark Brown)
Date: Tue, 7 Jan 2014 15:38:46 +0000
Subject: [PATCH 08/11] ASoC: ux500: Store DMA data in the DAI differently
 in the pdata and DT case
In-Reply-To: <1387468508-12286-9-git-send-email-lee.jones@linaro.org>
References: <1387468508-12286-1-git-send-email-lee.jones@linaro.org>
 <1387468508-12286-9-git-send-email-lee.jones@linaro.org>
Message-ID: <20140107153846.GQ31886@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 19, 2013 at 03:55:05PM +0000, Lee Jones wrote:
> In this patch we do two things. Firstly, instead of open coding the
> store of DMA data in to the DAI for later use, we use the API provided.
> Secondly we create and store similar DMA data for the DT case, only
> this time we use 'struct snd_dmaengine_dai_dma_data' which is provided
> by the core for this very reason.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140107/5c440b3b/attachment.sig>
