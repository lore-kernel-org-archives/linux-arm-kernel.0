From: broonie@kernel.org (Mark Brown)
Date: Wed, 27 Nov 2013 15:50:23 +0000
Subject: [Patch v2 1/2] ASoC: atmel: sam9x5_wm8731: fix oops when unload
 module
In-Reply-To: <1385546710-11308-1-git-send-email-voice.shen@atmel.com>
References: <1385546710-11308-1-git-send-email-voice.shen@atmel.com>
Message-ID: <20131127155023.GB14725@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 27, 2013 at 06:05:09PM +0800, Bo Shen wrote:
> As the priv is not assigned to card->drvdata, it is NULL, so when
> unload module, it will cause NULL pointer oops.
> Assign priv to card->drvdata to fix this issue.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131127/4222d259/attachment.sig>
