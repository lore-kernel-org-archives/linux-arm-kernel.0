From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 16 Feb 2017 17:52:09 +0100
Subject: [GIT PULL] Amlogic 64-bit DT updates for v4.11, round 2
In-Reply-To: <7hmve3umk9.fsf@baylibre.com>
References: <7hmve3umk9.fsf@baylibre.com>
Message-ID: <CAK8P3a2s+CUDQLXOEWTTSV8hXZZNfYogWQNc-SJNP=DTCe-c0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 3, 2017 at 8:00 PM, Kevin Hilman <khilman@baylibre.com> wrote:
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-dt64-2
>
> for you to fetch changes up to 6b6a1867667a90f399762dc1ee6add5b4aa646c9:
>
>   ARM64: dts: meson-gxbb-p200: add ADC laddered keys (2017-01-30 10:47:59 -0800)
>
> ----------------------------------------------------------------
> Amlogic DT updates for v4.11, round 2
> - add SAR ADC driver
> - add ADC laddered keys to meson-gxbb-p200 board

Like the Samsung changes that also have a dependency on clk (actually
from round 1
here), I have pulled this into a new next/late branch that we may or
may not send this
merge window. The hope was to avoid this kind of dependency in DT branches, but
we could make one last exception for 4.11.

     Arnd
