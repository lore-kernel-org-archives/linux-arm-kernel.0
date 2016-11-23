From: robh@kernel.org (Rob Herring)
Date: Wed, 23 Nov 2016 17:02:17 -0600
Subject: [PATCH v2] ARM: dts: AM571x-IDK Initial Support
In-Reply-To: <20161122041732.8385-1-lokeshvutla@ti.com>
References: <20161122041732.8385-1-lokeshvutla@ti.com>
Message-ID: <20161123230217.iq5fyyazgzdaccqv@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 22, 2016 at 09:47:32AM +0530, Lokesh Vutla wrote:
> From: Schuyler Patton <spatton@ti.com>
> 
> The AM571x-IDK board is a board based on TI's AM5718 SOC
> which has a single core 1.5GHz A15 processor. This board is a
> development platform for the Industrial market with:
> - 1GB of DDR3L
> - Dual 1Gbps Ethernet
> - HDMI,
> - PRU-ICSS
> - uSD
> - 16GB eMMC
> - CAN
> - RS-485
> - PCIe
> - USB3.0
> - Video Input Port
> - Industrial IO port and expansion connector
> 
> The link to the data sheet and TRM can be found here:
> 
> http://www.ti.com/product/AM5718
> 
> Initial support is only for basic peripherals.
> 
> Signed-off-by: Schuyler Patton <spatton@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> ---
> Cahnges since v1:
> - Dropped "ti,dra722", and "ti,dra72" from compatibles
> - Fixes few node names as suggested by Rob.
> Logs: http://pastebin.ubuntu.com/23515001/
> 
>  .../devicetree/bindings/arm/omap/omap.txt          |  3 +
>  arch/arm/boot/dts/Makefile                         |  1 +
>  arch/arm/boot/dts/am571x-idk.dts                   | 81 ++++++++++++++++++++++
>  3 files changed, 85 insertions(+)
>  create mode 100644 arch/arm/boot/dts/am571x-idk.dts

Acked-by: Rob Herring <robh@kernel.org>
