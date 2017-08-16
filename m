From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 16 Aug 2017 23:05:07 +0200
Subject: [GIT PULL] Renesas ARM Based SoC DT Bindings Updates for v4.14
In-Reply-To: <cover.1501512759.git.horms+renesas@verge.net.au>
References: <cover.1501512759.git.horms+renesas@verge.net.au>
Message-ID: <CAK8P3a3oa_0sEy=mQgBDS3mXw8kTGYbQ2z64PMGB7HTs1HBLCg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 31, 2017 at 5:04 PM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Renesas ARM Based SoC DT Bindings Updates for v4.14
>
> * Document R-Car D3 (r8a77995) SoC and Draak board
>
> * Document reserved SRAM for the SMP jump stub on R-Car Gen2 and RZ/G1 SoCs
>
>   Geert Uytterhoeven says, "+Renesas R-Car Gen2 and RZ/G1 SoCs need a small
>   piece of SRAM for the jump stub +for secondary CPU bringup and CPU
>   hotplug.  +This memory is reserved by adding a child node to a
>   "mmio-sram" node..."
>
> * Add a VSP channel index to DU vsps
>
>   Laurent Pinchart says, "multiple LIF instances in the VSP. The current DT
>   bindings don't support specifying that kind of SoC integration scheme.
>   Extend them with a VSP channel index."
>
> * Add R-Car M3-W (r8a7796) HDMI TX DT bindings
>
>   This is compatible with existing R-Car H3 (r8a7795) support

Pulled into next/dt, thanks!

       Arnd
