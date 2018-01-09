From: robh@kernel.org (Rob Herring)
Date: Mon, 8 Jan 2018 21:40:42 -0600
Subject: [PATCH v2 6/8] dt-bindings: ARM: sunxi: Document A80 SoC secure
 SRAM usage by SMP hotplug
In-Reply-To: <20180104143754.2425-7-wens@csie.org>
References: <20180104143754.2425-1-wens@csie.org>
 <20180104143754.2425-7-wens@csie.org>
Message-ID: <20180109034042.f5hcvwjewnsrw52d@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 04, 2018 at 10:37:52PM +0800, Chen-Yu Tsai wrote:
> On the Allwinner A80 SoC the BROM supports hotplugging the primary core
> (cpu0) by checking two 32bit values at a specific location within the
> secure SRAM block. This region needs to be reserved and accessible to
> the SMP code.
> 
> Document its usage.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  .../devicetree/bindings/arm/sunxi/smp-sram.txt     | 44 ++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/sunxi/smp-sram.txt

Reviewed-by: Rob Herring <robh@kernel.org>
