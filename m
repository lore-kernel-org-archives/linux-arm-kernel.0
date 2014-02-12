From: broonie@kernel.org (Mark Brown)
Date: Wed, 12 Feb 2014 17:23:42 +0000
Subject: [PATCH v3 0/2] ASoC: atmel_ssc_dai: add option to choose clock
In-Reply-To: <1392012586-30790-1-git-send-email-voice.shen@atmel.com>
References: <1392012586-30790-1-git-send-email-voice.shen@atmel.com>
Message-ID: <20140212172342.GI28112@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 10, 2014 at 02:09:44PM +0800, Bo Shen wrote:
> When SSC work in slave mode, the clock can come from TK pin and also
> can come from RK pin, this is hardware design decided. So, make it
> available to choose where the clock from.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140212/dbd09126/attachment.sig>
