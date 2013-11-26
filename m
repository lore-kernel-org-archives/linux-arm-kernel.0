From: broonie@kernel.org (Mark Brown)
Date: Tue, 26 Nov 2013 13:22:44 +0000
Subject: [PATCH 1/2] ASoC: atmel: sam9x5_wm8731: fix oops when unload
 module
In-Reply-To: <1385439472-23352-1-git-send-email-voice.shen@atmel.com>
References: <1385439472-23352-1-git-send-email-voice.shen@atmel.com>
Message-ID: <20131126132244.GP14725@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 26, 2013 at 12:17:51PM +0800, Bo Shen wrote:

> +	card->drvdata = priv;

You should use snd_soc_card_set_drvdata() for this.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131126/60359891/attachment.sig>
