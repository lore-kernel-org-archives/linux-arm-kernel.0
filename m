From: robh@kernel.org (Rob Herring)
Date: Mon, 9 Jan 2017 12:41:16 -0600
Subject: [PATCHv3 3/5] pinctrl: mvebu: pinctrl driver for 98DX3236 SoC
In-Reply-To: <20170106041517.9589-4-chris.packham@alliedtelesis.co.nz>
References: <20170105033641.6212-1-chris.packham@alliedtelesis.co.nz>
 <20170106041517.9589-1-chris.packham@alliedtelesis.co.nz>
 <20170106041517.9589-4-chris.packham@alliedtelesis.co.nz>
Message-ID: <20170109184116.ewklw5eissmoo6om@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 06, 2017 at 05:15:00PM +1300, Chris Packham wrote:
> From: Kalyan Kinthada <kalyan.kinthada@alliedtelesis.co.nz>
> 
> This pinctrl driver supports the 98DX3236, 98DX3336 and 98DX4251 SoCs
> from Marvell.
> 
> Signed-off-by: Kalyan Kinthada <kalyan.kinthada@alliedtelesis.co.nz>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>     Changes in v2:
>     - include sdio support for the 98DX4251
>     Changes in v3:
>     - None
> 
>  .../pinctrl/marvell,armada-98dx3236-pinctrl.txt    |  46 ++++++

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/pinctrl/mvebu/pinctrl-armada-xp.c          | 155 +++++++++++++++++++++
>  2 files changed, 201 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/marvell,armada-98dx3236-pinctrl.txt
