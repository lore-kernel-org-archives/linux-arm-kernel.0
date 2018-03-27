From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 27 Mar 2018 14:52:37 +0200
Subject: [GIT PULL] Amlogic 32-bit DT updates for v4.17, redo
In-Reply-To: <7h1sgeqv5i.fsf@baylibre.com>
References: <7h1sgeqv5i.fsf@baylibre.com>
Message-ID: <CAK8P3a37TQ4RGi6KKpjpnK=xudyyug5=DpT8fuTfUWtyVfHBQw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 20, 2018 at 10:44 PM, Kevin Hilman <khilman@baylibre.com> wrote:
> The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:
>
>   Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)
>
> are available in the git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-dt-1
>
> for you to fetch changes up to 4e461e62fc987ed5edb82e2a902fd93f4dccae8f:
>
>   ARM: dts: meson8b: the CBUS GPIO controller only has 83 GPIOs (2018-03-20 14:32:31 -0700)
>
> ----------------------------------------------------------------
> Amlogic 32-bit DT updates for v4.17
> - odroid-c1: add microSD, ethernet, USB reset
> - add reset controller
> - fix requesting GPIOs greater than GPIOZ_3

Pulled into next/dt, thanks!

      Arnd
