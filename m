From: robh@kernel.org (Rob Herring)
Date: Mon, 17 Jul 2017 12:53:07 -0500
Subject: [PATCH v3 1/6] dt-bindings: Amlogic: Add Meson8 and Meson8b SMP
 related documentation
In-Reply-To: <20170713103113.21560-2-martin.blumenstingl@googlemail.com>
References: <20170713103113.21560-1-martin.blumenstingl@googlemail.com>
 <20170713103113.21560-2-martin.blumenstingl@googlemail.com>
Message-ID: <20170717175307.ntxkhmynwuroak7v@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 13, 2017 at 12:31:08PM +0200, Martin Blumenstingl wrote:
> From: Carlo Caione <carlo@endlessm.com>
> 
> With this patch we add documentation for:
> 
> * power-management-unit: the PMU is used to bring up the cores during
>   SMP operations
> * sram: among other things the sram is used to store the first code
>   executed by the core when it is powered up
> * cpu-enable-method: the CPU enable method used by Amlogic Meson8 and
>   Meson8b SoCs
> 
> Signed-off-by: Carlo Caione <carlo@endlessm.com>
> [also add Meson8 to the documentation]
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  .../devicetree/bindings/arm/amlogic/pmu.txt        | 18 ++++++++++++
>  .../devicetree/bindings/arm/amlogic/smp-sram.txt   | 32 ++++++++++++++++++++++
>  Documentation/devicetree/bindings/arm/cpus.txt     |  2 ++
>  3 files changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/amlogic/pmu.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/amlogic/smp-sram.txt

Acked-by: Rob Herring <robh@kernel.org>
