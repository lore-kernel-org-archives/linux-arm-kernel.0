From: robh@kernel.org (Rob Herring)
Date: Wed, 15 Feb 2017 16:47:27 -0600
Subject: [PATCH v2 5/6] ARM: dts: mvebu: Move mv98dx3236 clock bindings
In-Reply-To: <20170207202815.20226-6-chris.packham@alliedtelesis.co.nz>
References: <20170207202815.20226-1-chris.packham@alliedtelesis.co.nz>
 <20170207202815.20226-6-chris.packham@alliedtelesis.co.nz>
Message-ID: <20170215224727.ijjzo7a4f35k63my@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 08, 2017 at 09:28:14AM +1300, Chris Packham wrote:
> This moves the coreclk binding for the 98dx3236 SoC to the DFX block
> where the sampled at reset register is located and switches to using the
> correct gating clock compatible string.

Moves why? It was wrong before?

> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
> 
> Notes:
>     Changes in v2:
>     - New. Split out from "clk: mvebu: Expand mv98dx3236-core-clock support"
> 
>  .../devicetree/bindings/clock/mvebu-core-clock.txt         |  7 +++++++
>  .../devicetree/bindings/clock/mvebu-gated-clock.txt        | 11 +++++++++++
>  arch/arm/boot/dts/armada-xp-98dx3236.dtsi                  | 14 +++++++-------
>  3 files changed, 25 insertions(+), 7 deletions(-)
