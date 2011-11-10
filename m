From: olof@lixom.net (Olof Johansson)
Date: Wed, 9 Nov 2011 16:53:21 -0800
Subject: [GIT PULL] arm/tegra fixes for 3.2-rc
In-Reply-To: <CAOesGMip77Y7PMiCRginfZDoGe9k3jj33adP1SkJfNO1BBbrig@mail.gmail.com>
References: <CAOesGMip77Y7PMiCRginfZDoGe9k3jj33adP1SkJfNO1BBbrig@mail.gmail.com>
Message-ID: <CAOesGMjSozfya6fP6o9aqsj7MQfCoi11tgZSHB66p9O87xwv3g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since Arnd is out, I'll collect fixes for 3.2-rc2 in arm-soc, and
pulled this one in there.

(I know, silly to send myself a pull request, but I wanted to post the
contents on the list).


-Olof

On Wed, Nov 9, 2011 at 1:34 PM, Olof Johansson <olof@lixom.net> wrote:
> Hi,
>
> A couple of fixes for 3.2-rc below. Nothing controversial.
>
>
> Thanks!
>
> -Olof
>
> The following changes since commit 1ea6b8f48918282bdca0b32a34095504ee65bab5:
>
> ?Linux 3.2-rc1 (2011-11-07 16:16:02 -0800)
>
> are available in the git repository at:
> ?git://git.kernel.org/pub/scm/linux/kernel/git/olof/tegra.git for-3.2/fixes
>
> Stephen Warren (2):
> ? ? ?arm/tegra: Don't create duplicate gpio and pinmux devices
> ? ? ?arm/dt: Fix ventana SDHCI power-gpios
>
> Yufeng Shen (1):
> ? ? ?arm/tegra: enable headphone detection gpio on seaboard
>
> ?arch/arm/boot/dts/tegra-ventana.dts ? ? ? ? ?| ? ?3 +--
> ?arch/arm/mach-tegra/board-dt.c ? ? ? ? ? ? ? | ? 13 +++++++------
> ?arch/arm/mach-tegra/board-harmony-pinmux.c ? | ? ?6 +++++-
> ?arch/arm/mach-tegra/board-paz00-pinmux.c ? ? | ? ?6 +++++-
> ?arch/arm/mach-tegra/board-seaboard-pinmux.c ?| ? ?6 +++++-
> ?arch/arm/mach-tegra/board-trimslice-pinmux.c | ? ?5 ++++-
> ?6 files changed, 27 insertions(+), 12 deletions(-)
>
