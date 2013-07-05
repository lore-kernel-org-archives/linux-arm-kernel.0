From: broonie@kernel.org (Mark Brown)
Date: Fri, 5 Jul 2013 19:06:03 +0100
Subject: [RFC PATCH 08/13] sound: sam9x5_wm8731: machine driver for
 at91sam9x5 wm8731 boards
In-Reply-To: <CACQ1gAji8KkjXee8o=9jt8O38611LBJ95yXimxbfn1qLaLOcnA@mail.gmail.com>
References: <1372667978-4718-1-git-send-email-richard.genoud@gmail.com>
 <1372667978-4718-9-git-send-email-richard.genoud@gmail.com>
 <51D2472B.2010407@atmel.com>
 <CACQ1gAji8KkjXee8o=9jt8O38611LBJ95yXimxbfn1qLaLOcnA@mail.gmail.com>
Message-ID: <20130705180603.GG27646@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 05, 2013 at 05:15:05PM +0200, Richard Genoud wrote:
> 2013/7/2 Bo Shen <voice.shen@atmel.com>:

> >> From: Nicolas Ferre <nicolas.ferre@atmel.com>
> >>
> >> Description of the Asoc machine driver for an at91sam9x5 based board
> >> with a wm8731 audio DAC. Wm8731 is clocked by a crystal and used as a
> >> master on the SSC/I2S interface. Its connections are a headphone jack
> >> and an Line input jack.

Always CC relevant maintainers and mailing lists on patches...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130705/fb98e36e/attachment.sig>
