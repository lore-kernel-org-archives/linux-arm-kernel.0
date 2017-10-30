From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 30 Oct 2017 14:36:36 +0100
Subject: [GIT PULL] Amlogic 64-bit DT updates for v4.15
In-Reply-To: <7hefpvqxbe.fsf@baylibre.com>
References: <7hefpvqxbe.fsf@baylibre.com>
Message-ID: <CAK8P3a0cO19miC8VU6mZ_L2FLpvfCpYPpseHViUJkSB-O1hWqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 22, 2017 at 12:41 PM, Kevin Hilman <khilman@baylibre.com> wrote:
> Amlogic 64-bit platforms: DT updates for v4.15
> - new SoC support: A113D
> - new boards: Tronsmart Vega S96, Khadas vim2
> - reserved memory fixups
> - gpio-names cleanups
> - MMC cleanups, enable high-speed modes
> - misc cleanups

I've had to 's/secmon at 05000000/secmon at 5000000/g' to avoid re-introducing
warnings that Rob had previously fixed, otherwise looks good, so I
pulled it into
next/dt with that fixup as an 'evil merge'. Thanks,

       Arnd
