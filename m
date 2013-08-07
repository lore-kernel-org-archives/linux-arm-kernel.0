From: broonie@kernel.org (Mark Brown)
Date: Wed, 7 Aug 2013 16:57:37 +0100
Subject: [PATCH 14/20] ASoC: pxa: use snd_dmaengine_dai_dma_data
In-Reply-To: <1375889649-14638-15-git-send-email-zonque@gmail.com>
References: <1375889649-14638-1-git-send-email-zonque@gmail.com>
 <1375889649-14638-15-git-send-email-zonque@gmail.com>
Message-ID: <20130807155737.GF6427@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 07, 2013 at 05:34:03PM +0200, Daniel Mack wrote:
> Use snd_dmaengine_dai_dma_data for passing the dma parameters from
> clients to the pxa pcm lib. This does no functional change, it's just an
> intermedia step to migrate the pxa bits over to dmaengine.
> 
> The calculation of dcmd is a transition hack which will be removed again
> in a later patch. It's just there to make the transition more readable.

Acked-by: Mark Brown <broonie@linaro.org>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130807/623ef729/attachment.sig>
