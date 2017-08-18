From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 18 Aug 2017 23:12:00 +0200
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC DT Updates for
 v4.14
In-Reply-To: <cover.1502962873.git.horms+renesas@verge.net.au>
References: <cover.1502962873.git.horms+renesas@verge.net.au>
Message-ID: <CAK8P3a3-5zdQ1h8jaO04eOv8qXtRMeJ7HDveZP89tf8qtnnmzg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 18, 2017 at 10:19 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Second Round of Renesas ARM Based SoC DT Updates for v4.14
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
> * Enable second CPU core on RZ/G1M (r8a7743)
>
>   The RZ/G1M has two CA15 cores running at up to 1.5GHz
>
> * Enable frequency scaling on RZ/G1M (r8a7743)
>
> * Add six I2C cores to RZ/G1M (r8a7743) SoC DT
>
>   This is a step towards enabling these cores on boards that use this SoC
>
> * Add CEC clock for HDMI transmitter to R-Car M2-W (r8a7791) Koelsch
>
>   Hans Verkuil says "The adv7511 on the Koelsch board has a 12 MHz fixed
>   clock for the CEC block. Specify this in the dts to enable CEC support."
>
> * Add PFC support to RZ/G1E (r8a7745) SoC and add Ethernet and SCIF2
>   pins to SK-RZG1E board.
>
>   This allows the kernel to control multiplexed pins for Ethernet
>   and SCIF2 rather than relying on setup inherited at boot.

Pulled into next/dt, thanks!

        Arnd
