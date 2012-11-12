From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 12 Nov 2012 13:00:43 +0100
Subject: [PATCH v2 1/5] ARM: zynq: dts: split up device tree
In-Reply-To: <052ad319f1599baa9a2fc840726a98f573e08672.1352400580.git.josh.cartwright@ni.com>
References: <cover.1352400580.git.josh.cartwright@ni.com>
 <052ad319f1599baa9a2fc840726a98f573e08672.1352400580.git.josh.cartwright@ni.com>
Message-ID: <CAHTX3dJN1RyuUnz3Ke7j2aiA1kvN5jLVvVEsjAc40tUjSMvTJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Josh,

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

We have had discussion about this dtsi stuff and also based on our
previous discussion
all trying to convince me that this solution is right solution.
I still have doubts but I will apply it to arm-next tree and we can
revisit it in future.

Thanks,
Michal
