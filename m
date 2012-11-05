From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 5 Nov 2012 12:32:17 +0100
Subject: [PATCH 4/8] ARM: zynq: dts: split up device tree
In-Reply-To: <1dc81a3260da0a911dbcabd737547b7bff16a99c.1351721190.git.josh.cartwright@ni.com>
References: <cover.1351721190.git.josh.cartwright@ni.com>
 <1dc81a3260da0a911dbcabd737547b7bff16a99c.1351721190.git.josh.cartwright@ni.com>
Message-ID: <CAHTX3dJKT=zZ5wYV-iB=XVba0ah7O18C9s8fo1M9WPs1NfeK-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/10/31 Josh Cartwright <josh.cartwright@ni.com>:
> The purpose of the created zynq-7000.dtsi file is to describe the
> hardware common to all Zynq 7000-based boards.  Also, get rid of the
> zynq-ep107 device tree, since it is not hardware anyone can purchase.
>
> Add a zc702 dts file based on the zynq-7000.dtsi.  Add it to the
> dts/Makefile so it is built with the 'dtbs' target.
>
> Signed-off-by: Josh Cartwright <josh.cartwright@ni.com>
> ---
>  arch/arm/boot/dts/Makefile                         |  1 +
>  .../boot/dts/{zynq-ep107.dts => zynq-7000.dtsi}    | 19 +++-----------
>  arch/arm/boot/dts/zynq-zc702.dts                   | 30 ++++++++++++++++++++++
>  arch/arm/mach-zynq/common.c                        |  3 ++-
>  4 files changed, 36 insertions(+), 17 deletions(-)
>  rename arch/arm/boot/dts/{zynq-ep107.dts => zynq-7000.dtsi} (79%)
>  create mode 100644 arch/arm/boot/dts/zynq-zc702.dts

Not going to apply this. We need to finish our discussion in
"[PATCH v4 1/5] zynq: use GIC device tree bindings" before.

Definitely I like idea to use "xlnx,zynq-7000" generic model name.

Thanks,
Michal
