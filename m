From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 31 Mar 2017 11:59:31 +0200
Subject: [GIT PULL] ARM: dts: uniphier: UniPhier DT updates for v4.12
In-Reply-To: <CAK7LNAScRBfD_2kDZYtr0S83kvLhSHAs0C4HjprNr5dKCSPRcw@mail.gmail.com>
References: <CAK7LNAScRBfD_2kDZYtr0S83kvLhSHAs0C4HjprNr5dKCSPRcw@mail.gmail.com>
Message-ID: <CAK8P3a3N-Y8_rB-9b-PqUqvBr+m6Auo292TMFpXqDK14PDPihg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 22, 2017 at 12:46 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> Hi Arnd, Olof,
>
> Here are UniPhier DT (32bit) updates for the v4.12 merge window.
> Please pull!
>
>
> The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:
>
>   Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
> tags/uniphier-dt-v4.12
>
> for you to fetch changes up to facc7a551cda4c7091b0413438b280e654659890:
>
>   ARM: dts: uniphier: add pagesize property to EEPROM of proto boards
> (2017-03-14 05:02:13 +0900)
>
> ----------------------------------------------------------------
> UniPhier ARM SoC DT updates for v4.12
>
> - Remove skeleton.dtsi inclusion
> - Fix W=* build warnings
> - Fix eMMC pin-mux node
> - Add pagesize properties to EEPROM nodes

Pulled into next/dt, thanks!

     Arnd
