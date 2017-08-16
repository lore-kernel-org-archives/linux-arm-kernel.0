From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 16 Aug 2017 23:50:22 +0200
Subject: [GIT PULL] arm64: dts: uniphier: UniPhier DT updates (64bit) for
 v4.14
In-Reply-To: <CAK7LNARP=6+63Cnjy-U57-0_Ue-5FamM-9SdBtfxkfmqHesxjQ@mail.gmail.com>
References: <CAK7LNARP=6+63Cnjy-U57-0_Ue-5FamM-9SdBtfxkfmqHesxjQ@mail.gmail.com>
Message-ID: <CAK8P3a0t7aLN_0=zUTG5K9RWUXjvbMoMwVPn4TGPw38cVdrgEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 16, 2017 at 5:01 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> Hi Arnd, Olof,
>
> Here are UniPhier DT (64bit) updates for the v4.14 merge window.
> Please pull!
>
>
> The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:
>
>   Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
> tags/uniphier-dt64-v4.14
>
> for you to fetch changes up to e5aefb380eafe176de066ddde1d354a167a9d474:
>
>   arm64: dts: uniphier: add Denali NAND controller nodes (2017-08-13
> 08:43:27 +0900)
>
> ----------------------------------------------------------------
> UniPhier ARM64 SoC DT updates for v4.14
>
> - add nodes for NAND, Watchdog
> - replace /include/ with #include
> - use #include <arm/...> instead of symlinks

Pulled into next/dt64, thanks!

       Arnd
