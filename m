From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 4 Feb 2013 18:34:30 +0000
Subject: [PATCH 0/4] ASoC: atmel: fixes for working as module
In-Reply-To: <1359604420-15171-1-git-send-email-voice.shen@atmel.com>
References: <1359604420-15171-1-git-send-email-voice.shen@atmel.com>
Message-ID: <20130204183430.GR4720@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 31, 2013 at 11:53:36AM +0800, Bo Shen wrote:
> The following patches fixes the audio part when working as module
> 
> Bo Shen (4):
>   ASoC: atmel_pcm: make it buildable as module
>   ASoC: atmel_ssc_dai: remove error set private data
>   ASoC: atmel_ssc_dai: correct sequence when unload
>   ASoC: sam9g20_wm8731: disable clock and correct sequence when unload

Applied all, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130204/bacfbc1a/attachment.sig>
