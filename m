From: broonie@kernel.org (Mark Brown)
Date: Tue, 31 Dec 2013 12:27:26 +0000
Subject: [Patch v2 2/2] ASoC: atmel: sam9x5_wm8731: remove
 platform_set_drvdata
In-Reply-To: <1385546710-11308-2-git-send-email-voice.shen@atmel.com>
References: <1385546710-11308-1-git-send-email-voice.shen@atmel.com>
 <1385546710-11308-2-git-send-email-voice.shen@atmel.com>
Message-ID: <20131231122726.GP31886@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 27, 2013 at 06:05:10PM +0800, Bo Shen wrote:
> When call snd_soc_register_card, it will set driver data to this
> device through dev_set_drvdata, then in driver, no need to call
> platform_set_drvdata again, so remove it.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131231/1e6a2c99/attachment.sig>
