From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 2 Dec 2012 13:28:27 +0900
Subject: [PATCH 1/2] ASoC: atmel-pcm: split into two file
In-Reply-To: <1354074373-7671-1-git-send-email-voice.shen@atmel.com>
References: <1354074373-7671-1-git-send-email-voice.shen@atmel.com>
Message-ID: <20121202042826.GV17981@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 28, 2012 at 11:46:12AM +0800, Bo Shen wrote:
> This patch is split original atmel-pcm.c into new atmel-pcm.c and
> atmel-pcm-pdc.c two files. The new atmel-pcm.c is the share routine
> while will be used for pdc or dma transfer.
> 
> Using SND_ATMEL_SOC_PDC to select using PDC for audio transfer

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121202/e50543f9/attachment.sig>
