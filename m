From: broonie@kernel.org (Mark Brown)
Date: Wed, 3 Jul 2013 10:52:57 +0100
Subject: [v2 0/5] ASoC: atmel-pcm: align with generic dmaengine framwork
In-Reply-To: <1372840680-2253-1-git-send-email-voice.shen@atmel.com>
References: <1372840680-2253-1-git-send-email-voice.shen@atmel.com>
Message-ID: <20130703095257.GF27646@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 03, 2013 at 04:37:55PM +0800, Bo Shen wrote:
> This patch set is based on linux next-20130701
> 
> mainly implement
>   - move set dma data from hw_params to startup callback to avoid memory leak
>   - align atmel pcm with generic dmaenigne framwork

Applied all, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130703/ddf15300/attachment.sig>
