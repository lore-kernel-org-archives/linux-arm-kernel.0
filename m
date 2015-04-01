From: broonie@kernel.org (Mark Brown)
Date: Wed, 1 Apr 2015 21:24:48 +0100
Subject: [PATCH] ASoC: atmel-pcm-pdc: merge atmel-pcm back in
In-Reply-To: <1427738094-6348-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1427738094-6348-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20150401202448.GB6023@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 30, 2015 at 07:54:54PM +0200, Alexandre Belloni wrote:
> atmel-pcm.c was split into two files to create a generic framework for both PDC
> and DMA.
> 
> atmel-pcm-dma.c is using the generic dmaengine framework since 95e0e07e710e
> (ASoC: atmel-pcm: use generic dmaengine framework).

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150401/6151b26b/attachment.sig>
