From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 16 Aug 2017 23:31:50 +0200
Subject: [GIT PULL] ARM: dts: uniphier: UniPhier DT updates for v4.14
In-Reply-To: <CAK7LNAQpsNrrrL2T8J1QYjA+9cmj8UO3JdTCZ7_WLGfdWC4G7w@mail.gmail.com>
References: <CAK7LNAQpsNrrrL2T8J1QYjA+9cmj8UO3JdTCZ7_WLGfdWC4G7w@mail.gmail.com>
Message-ID: <CAK8P3a1qY1UCVcFmmJ4Df=27xZqeEh91XZdW1udMSUNcb-ZeyA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 16, 2017 at 5:00 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> ----------------------------------------------------------------
> UniPhier ARM SoC DT updates for v4.14
>
> - complete migrating to SPDX License Identifier
> - remove support for old SoC
> - add nodes for NAND, Audio pinctrl
> - replace /include/ with #include
>
> ----------------------------------------------------------------
> Katsuhiro Suzuki (1):
>       ARM: dts: uniphier: add audio out pin-mux node
>
> Masahiro Yamada (4):
>       ARM: dts: uniphier: use SPDX-License-Identifier (2nd)
>       ARM: dts: uniphier: remove sLD3 SoC support
>       ARM: dts: uniphier use #include instead of /include/
>       ARM: dts: uniphier: add Denali NAND controller node

Pulled into next/dt, but please clarify one question:

How likely is it that there are still users of the sLD3 SoC on
mainline kernels? The commit just states that it is too hard
to maintain, but the more important question is whether anyone
cares about it breaking.

      Arnd
