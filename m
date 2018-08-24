From: olof@lixom.net (Olof Johansson)
Date: Fri, 24 Aug 2018 08:28:39 -0700
Subject: [GIT PULL] Reset controller changes for v4.19, part 2
In-Reply-To: <1533551840.4204.11.camel@pengutronix.de>
References: <1533551840.4204.11.camel@pengutronix.de>
Message-ID: <CAOesGMiL=Vk1cZz9vbysT_ULd=grr0ij9QJiR7JPHMp+BvA3OQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 8, 2018 at 4:47 AM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> Dear arm-soc maintainers,
>
> The following changes since commit 6b39fd590aebca1a6a4c827f29f14d2b6df3939d:
>
>   reset: uniphier: add reset control support for SPI (2018-07-19 11:19:47 +0200)
>
> are available in the git repository at:
>
>   git://git.pengutronix.de/git/pza/linux.git tags/reset-for-4.19-2
>
> for you to fetch changes up to d903779b58be442f3afd2c51c46c7cf19c97684e:
>
>   reset: meson: add meson audio arb driver (2018-07-20 18:17:31 +0200)
>
> ----------------------------------------------------------------
> Reset controller changes for v4.19, part 2
>
> This adds a single new driver for the Amlogic Meson Audio Memory Arbiter
> resets.

I didn't merge this in time for the main pull requests, but it's been
sitting in -next through the reset tree so I merged it into a -late
branch now and will send in tomorrow.


-Olof
