From: broonie@kernel.org (Mark Brown)
Date: Sat, 21 Jun 2014 11:37:56 +0100
Subject: [PATCH v2 2/4] ASoC: atmel_ssc_dai: enable fslen extension feature
In-Reply-To: <1402481682-9811-3-git-send-email-voice.shen@atmel.com>
References: <1402481682-9811-1-git-send-email-voice.shen@atmel.com>
 <1402481682-9811-3-git-send-email-voice.shen@atmel.com>
Message-ID: <20140621103756.GA5099@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 11, 2014 at 06:14:40PM +0800, Bo Shen wrote:
> When SSC work as master, it will generate the frame sync signal.
> On old SoCs, it only supports frame sync length less or equal to
> 16bits, on newer SoCs, it supports frame sync length extension,
> which can support frame size larger than 16 bits.
> So, add this to make it supports playback 24/32 bits audio clips.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140621/6d61b03e/attachment.sig>
