From: robh@kernel.org (Rob Herring)
Date: Tue, 23 May 2017 10:18:08 -0500
Subject: [PATCH 1/7] clk: mvebu: cp110 fix name of the GOP gate clock
In-Reply-To: <062f869fb140c2626efadef80f325d9f03c330f6.1495208533.git-series.gregory.clement@free-electrons.com>
References: <cover.737145f06ff0191d1a9210bcd141e679bf45fe5f.1495208533.git-series.gregory.clement@free-electrons.com>
 <062f869fb140c2626efadef80f325d9f03c330f6.1495208533.git-series.gregory.clement@free-electrons.com>
Message-ID: <20170523151808.iz7jtqgdfbskfh4y@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 19, 2017 at 05:55:19PM +0200, Gregory CLEMENT wrote:
> Actually the GOP clock (bit 18) is not at all used for emmc but only
> for GOP: let's fix the name.
> 
> Changing the name in the device tree is not an issue because the name
> itself is not used to reference the clock. Thanks to this the ABI remains
> backward compatible.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/arm/marvell/cp110-system-controller0.txt | 6 +++---
>  arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi                       | 2 +-
>  arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi                        | 2 +-
>  drivers/clk/mvebu/cp110-system-controller.c                                | 5 +++--
>  4 files changed, 8 insertions(+), 7 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
