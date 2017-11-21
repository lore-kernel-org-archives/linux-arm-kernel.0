From: robh@kernel.org (Rob Herring)
Date: Tue, 21 Nov 2017 12:29:48 -0600
Subject: [PATCH 3/6] arm: dts: marvell: Add missing #phy-cells to
 usb-nop-xceiv
In-Reply-To: <20171109222614.5719-3-robh@kernel.org>
References: <20171109222614.5719-1-robh@kernel.org>
 <20171109222614.5719-3-robh@kernel.org>
Message-ID: <CAL_JsqJhq7TqdaS+i8yk8rRJM0hH2hyk8eybXsnR0D8QoncXZg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 9, 2017 at 4:26 PM, Rob Herring <robh@kernel.org> wrote:
> "usb-nop-xceiv" is using the phy binding, but is missing #phy-cells
> property. This is probably because the binding was the precursor to the phy
> binding.
>
> Fixes the following warning in Marvell dts files:
>
> Warning (phys_property): Missing property '#phy-cells' in node ...
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Gregory Clement <gregory.clement@free-electrons.com>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
> Please apply to Marvell tree.

Ping.

Arnd, can you apply if you'd like the warnings fixed and Marvell
maintainers don't respond.

>
>  arch/arm/boot/dts/armada-385-db-ap.dts          | 1 +
>  arch/arm/boot/dts/armada-385-linksys.dtsi       | 1 +
>  arch/arm/boot/dts/armada-385-synology-ds116.dts | 2 ++
>  arch/arm/boot/dts/armada-388-gp.dts             | 2 ++
>  4 files changed, 6 insertions(+)
