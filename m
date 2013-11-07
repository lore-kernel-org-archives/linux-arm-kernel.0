From: broonie@kernel.org (Mark Brown)
Date: Thu, 7 Nov 2013 11:36:11 +0000
Subject: [PATCH 08/13] ASoC: generic-dmaengine-pcm: Clear slave_config
 memory
In-Reply-To: <1383732985-18928-9-git-send-email-lee.jones@linaro.org>
References: <1383732985-18928-1-git-send-email-lee.jones@linaro.org>
 <1383732985-18928-9-git-send-email-lee.jones@linaro.org>
Message-ID: <20131107113611.GV2493@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 06, 2013 at 10:16:20AM +0000, Lee Jones wrote:
> We currently assume that the DMA Slave Config will be fully populated
> by the platform, however some DMA Engines make decisions based on zero
> (default) flags such as DMA_SLAVE_BUSWIDTH_UNDEFINED and as this is a
> static declaration we need to memset it to clear the data area.

Applied, thanks - given how near we are to the merge window the whole
series isn't going to go in for v3.13 but this ought to do so.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131107/a530bfec/attachment.sig>
