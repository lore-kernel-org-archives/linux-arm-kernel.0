From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 5 Jan 2018 12:28:13 +0100
Subject: [GIT PULL] Reset controller changes for v4.16
In-Reply-To: <1514884597.5080.3.camel@pengutronix.de>
References: <1514884597.5080.3.camel@pengutronix.de>
Message-ID: <CAK8P3a0O74uJxh8wVVdZKGBn59ndmp8MaEvGfSzhQmzFEQYemg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 2, 2018 at 10:16 AM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> Dear arm-soc maintainers,
>
> Happy New Year! Please consider merging this tag for v4.16. It adds
> Meson-AXG reset support and fixes a few issues with the reset include
> header: device_reset_optional is fixed to be really optional, unused
> headers are pruned, and useless warnings and deprecated API calls are
> removed.

Pulled into next/drivers.

I ended up using a variant of your text above as the changelog, rather than
the bullet list that more or less shows the same things as the shortlog.
Generally speaking, I'd prefer to have that kind of description in full
sentences in the git tag as well. Thanks,

      Arnd
