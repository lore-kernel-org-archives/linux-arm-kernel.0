From: robh@kernel.org (Rob Herring)
Date: Mon, 11 Sep 2017 17:00:59 -0500
Subject: [PATCH 2/3] arm64: allwinner: a64: Add device node for DMA
 controller
In-Reply-To: <20170830233609.13855-3-stefan.bruens@rwth-aachen.de>
References: <20170830233609.13855-1-stefan.bruens@rwth-aachen.de>
 <20170830233609.13855-3-stefan.bruens@rwth-aachen.de>
Message-ID: <20170911220059.qzokhgdsykkgrllq@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 31, 2017 at 01:36:08AM +0200, Stefan Br?ns wrote:
> The A64 SoC has a DMA controller that supports 8 DMA channels
> to and from various peripherals.
> 
> Add a device node for it.
> 
> Signed-off-by: Stefan Br?ns <stefan.bruens@rwth-aachen.de>
> ---
>  Documentation/devicetree/bindings/dma/sun6i-dma.txt | 1 +
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi       | 9 +++++++++
>  2 files changed, 10 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
