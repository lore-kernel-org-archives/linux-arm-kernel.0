From: broonie@kernel.org (Mark Brown)
Date: Wed, 18 Dec 2013 11:31:00 +0000
Subject: [PATCH] ASoC: wm8904: fix DSP mode B configuration
In-Reply-To: <1387337183-16814-1-git-send-email-voice.shen@atmel.com>
References: <1387337183-16814-1-git-send-email-voice.shen@atmel.com>
Message-ID: <20131218113100.GJ28455@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 18, 2013 at 11:26:23AM +0800, Bo Shen wrote:
> When wm8904 work in DSP mode B, we still need to configure it to
> work in DSP mode. Or else, it will work in Right Justified mode.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131218/12743a85/attachment.sig>
