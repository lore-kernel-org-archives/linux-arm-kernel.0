From: broonie@kernel.org (Mark Brown)
Date: Tue, 6 Aug 2013 18:11:56 +0100
Subject: [PATCH v6 2/8] ASoC: atmel: machine driver for at91sam9x5-wm8731
 boards
In-Reply-To: <1375180329-4860-3-git-send-email-richard.genoud@gmail.com>
References: <1375180329-4860-1-git-send-email-richard.genoud@gmail.com>
 <1375180329-4860-3-git-send-email-richard.genoud@gmail.com>
Message-ID: <20130806171156.GN6427@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 30, 2013 at 12:32:03PM +0200, Richard Genoud wrote:
> From: Nicolas Ferre <nicolas.ferre@atmel.com>
> 
> Description of the Asoc machine driver for an at91sam9x5 based board
> with a wm8731 audio DAC. Wm8731 is clocked by a crystal and used as a
> master on the SSC/I2S interface. Its connections are a headphone jack
> and an Line input jack.

Applied, thanks.  We should really be able to merge this with the
sam9g20ek driver that's here already but we can do that later.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130806/712a5b64/attachment.sig>
