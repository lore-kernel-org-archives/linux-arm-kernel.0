From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 20 Nov 2012 17:57:30 +0900
Subject: [PATCH 2/2] ASoC: atmel-pcm: add dma support
In-Reply-To: <1353400698-19384-2-git-send-email-voice.shen@atmel.com>
References: <1353400698-19384-1-git-send-email-voice.shen@atmel.com>
 <1353400698-19384-2-git-send-email-voice.shen@atmel.com>
Message-ID: <20121120085728.GX10560@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 20, 2012 at 04:38:18PM +0800, Bo Shen wrote:
> Change xfer_size name to apply to PDC and DMA aswell.
> Specify overrun bit in interrupt mask.
> Add dmaengine specific routines and replace PDC ones in
> pcm_ops if appropriate.
> Uses cyclic DMA API for queuing samples.

If you're using dmaengine you really need a *very* good reason not to
use the core dmaengine support...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121120/54b17acb/attachment.sig>
