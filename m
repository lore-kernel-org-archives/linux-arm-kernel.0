From: broonie@kernel.org (Mark Brown)
Date: Wed, 7 Aug 2013 17:07:43 +0100
Subject: [PATCH 17/20] ASoC: pxa: pxa-pcm-lib: switch over to
 snd-soc-dmaengine-pcm
In-Reply-To: <1375889649-14638-18-git-send-email-zonque@gmail.com>
References: <1375889649-14638-1-git-send-email-zonque@gmail.com>
 <1375889649-14638-18-git-send-email-zonque@gmail.com>
Message-ID: <20130807160743.GI6427@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 07, 2013 at 05:34:06PM +0200, Daniel Mack wrote:
> This patch removes the old PXA DMA API usage and switches over to
> generic functions provided by snd-soc-dmaengine-pcm.
> 
> More cleanups may be done on top of this, and some function stubs can
> now be removed completetly. However, the intention here was to keep
> the transition as small as possible.

Has this been tested with the standalone non-ASoC PXA AC'97 driver?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130807/48f7b924/attachment-0001.sig>
