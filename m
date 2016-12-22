From: robh@kernel.org (Rob Herring)
Date: Thu, 22 Dec 2016 16:48:35 -0600
Subject: [PATCH 3/5] pinctrl: mvebu: pinctrl driver for 98DX3236 SoC
In-Reply-To: <20161222041328.3303-4-chris.packham@alliedtelesis.co.nz>
References: <20161222041328.3303-1-chris.packham@alliedtelesis.co.nz>
 <20161222041328.3303-4-chris.packham@alliedtelesis.co.nz>
Message-ID: <20161222224835.xoillysatrjvdspr@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 22, 2016 at 05:13:26PM +1300, Chris Packham wrote:
> From: Kalyan Kinthada <kalyan.kinthada@alliedtelesis.co.nz>
> 
> This pinctrl driver supports the 98DX3236, 98DX3336 and 98DX4251 SoCs
> from Marvell.
> 
> Signed-off-by: Kalyan Kinthada <kalyan.kinthada@alliedtelesis.co.nz>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>  .../pinctrl/marvell,armada-98dx3236-pinctrl.txt    |  46 +++++++

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/pinctrl/mvebu/pinctrl-armada-xp.c          | 145 +++++++++++++++++++++
>  2 files changed, 191 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/marvell,armada-98dx3236-pinctrl.txt
