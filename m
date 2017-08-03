From: robh@kernel.org (Rob Herring)
Date: Thu, 3 Aug 2017 11:30:49 -0500
Subject: [PATCH 01/10] dt-bindings: add binding for the SY8160A voltage
 regulator
In-Reply-To: <20170723102749.17323-2-icenowy@aosc.io>
References: <20170723102749.17323-1-icenowy@aosc.io>
 <20170723102749.17323-2-icenowy@aosc.io>
Message-ID: <20170803163049.3v24y763c4giz7ov@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 23, 2017 at 06:27:40PM +0800, Icenowy Zheng wrote:
> From: Ondrej Jirman <megous@megous.com>
> 
> SY8106A is an I2C-controlled adjustable voltage regulator made by
> Silergy Corp.
> 
> Add its device tree binding.
> 
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> [Icenowy: Change commit message]
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  .../bindings/regulator/sy8106a-regulator.txt        | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/sy8106a-regulator.txt

Acked-by: Rob Herring <robh@kernel.org>
