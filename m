From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 18 Aug 2017 23:15:01 +0200
Subject: [GIT PULL] Second Round of Renesas ARM64 Based SoC DT Updates for
 v4.14
In-Reply-To: <cover.1502961153.git.horms+renesas@verge.net.au>
References: <cover.1502961153.git.horms+renesas@verge.net.au>
Message-ID: <CAK8P3a0Er5WQMF5+1G_oDHzd2Qp56sCrbY6kkBD_sBeMiwz_yw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 18, 2017 at 10:19 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Second Round of Renesas ARM64 Based SoC DT Updates for v4.14
>
> * Add PFC device node to R-Car D3 (r8a77995)
>
>   This is a step towards enabling devices that use multiplexed pins
>   - including ethernet - on boards that use the r8a7796 SoC.
>
> * Add USB nodes to R-Car M3-W (r8a7796)
>
>   This is a step towards enabling USB devices on boards that
>   use the r8a7796 SoC.
>
> * Use newly added Gen-3 fallback compat string
>
>   This is consistent with ongoing efforts to use per-generation
>   fallback strings where appropriate across devices found
>   on R-Car SoCs. The aim of the effort being to strike a balance
>   between the limited information available about the compatibility
>   of devices found on different SoCs and the desire to ease enabling
>   devices on new SoCs.
>
>   This has no run-time effect due to the presence of a per-SoC
>   compat string.
>
> * Cleanup whitespace and extra LVDS port label
>
>   Minor cleanups, no run-time effect.

Pulled into next/dt64, thanks!

        Arnd
