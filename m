From: broonie@kernel.org (Mark Brown)
Date: Mon, 2 Feb 2015 12:19:28 +0000
Subject: [PATCH] ASoC: atmel-pcm-dma: won't check direction when
 configure dma
In-Reply-To: <1422859486-11051-1-git-send-email-voice.shen@atmel.com>
References: <1422859486-11051-1-git-send-email-voice.shen@atmel.com>
Message-ID: <20150202121928.GR21293@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 02, 2015 at 02:44:46PM +0800, Bo Shen wrote:
> As DMA framework request DMA using direction only in prep_slave
> function, (The At91 xdma driver has adapted to this request).
> So won't check direction when do DMA configuration.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150202/1262aa76/attachment.sig>
