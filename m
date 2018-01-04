From: broonie@kernel.org (Mark Brown)
Date: Thu, 4 Jan 2018 12:02:44 +0000
Subject: [RESEND PATCH v2 14/15] ASoC: qcom: apq8096: Add db820c machine
 driver
In-Reply-To: <f72f32dd-e248-47c3-23cc-eabe1b85d9ae@codeaurora.org>
References: <20171214173402.19074-1-srinivas.kandagatla@linaro.org>
 <20171214173402.19074-15-srinivas.kandagatla@linaro.org>
 <f72f32dd-e248-47c3-23cc-eabe1b85d9ae@codeaurora.org>
Message-ID: <20180104120244.GE10774@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 03, 2018 at 09:20:45AM -0800, Stephen Boyd wrote:
> On 12/14/2017 09:34 AM, srinivas.kandagatla at linaro.org wrote:

> > uThis patch adds support to DB820c machine driver.

> > +	ret = dma_coerce_mask_and_coherent(card->dev, DMA_BIT_MASK(32));

> Why do we need to do this? Can you add some sort of comment in the code
> about why?

And why are we applying DMA restrictions in a machine driver?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180104/e5b6f774/attachment.sig>
