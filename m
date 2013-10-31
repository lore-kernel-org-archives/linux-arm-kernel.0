From: broonie@kernel.org (Mark Brown)
Date: Thu, 31 Oct 2013 08:33:16 -0700
Subject: [RFC 4/4] ASoC: RX-51: Add DT support to sound driver
In-Reply-To: <CACRpkdb1dAiDCeZkOiZ6inbDruaUwLgk3joWwuQmSRNZ9WkDGw@mail.gmail.com>
References: <1382909086-10493-1-git-send-email-sre@debian.org>
 <1382909086-10493-5-git-send-email-sre@debian.org>
 <CACRpkdb1dAiDCeZkOiZ6inbDruaUwLgk3joWwuQmSRNZ9WkDGw@mail.gmail.com>
Message-ID: <20131031153316.GB2493@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 31, 2013 at 07:44:22AM -0700, Linus Walleij wrote:
> On Sun, Oct 27, 2013 at 2:24 PM, Sebastian Reichel <sre@debian.org> wrote:

> > +- eci-sw-gpio: GPIO for ECI SW
> > +- speaker-amp-gpio: GPIO for Speaker Amp

> Can you please spell out the acronyms? ECI? SW? Amp?

> I guess SW=switch, Amp=amplifier, but ECI beats me.

ECI is the name of Nokia's accesory interface spec, it should be as
clear as GPIO for anyone working on Nokia hardware (which this is).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131031/4c452316/attachment-0001.sig>
