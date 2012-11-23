From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 23 Nov 2012 23:27:48 +0900
Subject: [PATCH 3/3] ASoC: atmel-pcm: add dma support
In-Reply-To: <1353651257-2476-4-git-send-email-voice.shen@atmel.com>
References: <1353651257-2476-1-git-send-email-voice.shen@atmel.com>
 <1353651257-2476-4-git-send-email-voice.shen@atmel.com>
Message-ID: <20121123142747.GP4529@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 23, 2012 at 02:14:17PM +0800, Bo Shen wrote:
> Add dmaengine specific routines and replace PDC ones in
> pcm_ops if appropriate.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> [voice.shen at atmel.com: adapt to soc dmaengine framework]
> Signed-off-by: Bo Shen <voice.shen@atmel.com>

Why is this not just two separate drivers?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121123/a44bbe27/attachment.sig>
