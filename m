From: robh@kernel.org (Rob Herring)
Date: Mon, 27 Feb 2017 09:00:25 -0600
Subject: [PATCH v3 4/6] ARM: dts: mvebu: Add binding for mv98dx3236-soc-id
In-Reply-To: <20170216085041.28337-5-chris.packham@alliedtelesis.co.nz>
References: <20170216085041.28337-1-chris.packham@alliedtelesis.co.nz>
 <20170216085041.28337-5-chris.packham@alliedtelesis.co.nz>
Message-ID: <20170227150025.hpdwjhg2hollew2m@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 16, 2017 at 09:50:38PM +1300, Chris Packham wrote:
> The DFX server on the 98dx3236 and compatible SoCs has an ID register.
> Add documentation and a binding for this.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
> 
> Notes:
>     Changes in v3:
>     - new, split from driver
> 
>  .../devicetree/bindings/arm/marvell/mv98dx3236-soc-id.txt  | 14 ++++++++++++++
>  arch/arm/boot/dts/armada-xp-98dx3236.dtsi                  |  5 +++++
>  2 files changed, 19 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/marvell/mv98dx3236-soc-id.txt

Acked-by: Rob Herring <robh@kernel.org>
