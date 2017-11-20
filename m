From: robh@kernel.org (Rob Herring)
Date: Mon, 20 Nov 2017 15:07:41 -0600
Subject: [PATCH v8 2/3] arm: dts: add Nuvoton NPCM750 device tree
In-Reply-To: <20171117190747.21642-3-brendanhiggins@google.com>
References: <20171117190747.21642-1-brendanhiggins@google.com>
 <20171117190747.21642-3-brendanhiggins@google.com>
Message-ID: <20171120210741.vi6hq3x7xiowd6zh@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 17, 2017 at 11:07:46AM -0800, Brendan Higgins wrote:
> Add a common device tree for all Nuvoton NPCM750 BMCs and a board
> specific device tree for the NPCM750 (Poleg) evaluation board.
> 
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Reviewed-by: Tomer Maimon <tmaimon77@gmail.com>
> Reviewed-by: Avi Fishman <avifishman70@gmail.com>
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> Tested-by: Tomer Maimon <tmaimon77@gmail.com>
> Tested-by: Avi Fishman <avifishman70@gmail.com>
> ---
> Changes since v7:
>   - Added arm,shared-override to l2 cache
>   - Cleaned up node names
>   - Cleaned up ranges properties
>   - Fixed address for nuvoton,npcm750-timer
>   - Dropped watchdog nodes for now since the properties in them are wrong
> ---
>  .../arm/cpu-enable-method/nuvoton,npcm7xx-smp      |  42 +++++
>  .../devicetree/bindings/arm/npcm/npcm.txt          |   6 +
>  arch/arm/boot/dts/nuvoton-npcm750-evb.dts          |  44 ++++++
>  arch/arm/boot/dts/nuvoton-npcm750.dtsi             | 171 +++++++++++++++++++++
>  include/dt-bindings/clock/nuvoton,npcm7xx-clks.h   |  39 +++++
>  5 files changed, 302 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/cpu-enable-method/nuvoton,npcm7xx-smp
>  create mode 100644 Documentation/devicetree/bindings/arm/npcm/npcm.txt
>  create mode 100644 arch/arm/boot/dts/nuvoton-npcm750-evb.dts
>  create mode 100644 arch/arm/boot/dts/nuvoton-npcm750.dtsi
>  create mode 100644 include/dt-bindings/clock/nuvoton,npcm7xx-clks.h

Reviewed-by: Rob Herring <robh@kernel.org>
