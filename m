From: broonie@kernel.org (Mark Brown)
Date: Tue, 3 Dec 2013 15:05:29 +0000
Subject: [PATCH] ASoC: wm8731: fix dsp mode configuration
In-Reply-To: <1386065094-26018-1-git-send-email-voice.shen@atmel.com>
References: <1386065094-26018-1-git-send-email-voice.shen@atmel.com>
Message-ID: <20131203150529.GX27568@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 03, 2013 at 06:04:54PM +0800, Bo Shen wrote:
> According to WM8731 "PD, Rev 4.9 October 2012" datasheet, when it
> works in DSP mode A, LRP = 1, while works in DSP mode B, LRP = 0.
> So, fix LRP for DSP mode as the datesheet specification.

Applied, thanks.  Please do remember to CC maintainers on things, you've
missed the Wolfson guys.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131203/db7e6eb6/attachment.sig>
