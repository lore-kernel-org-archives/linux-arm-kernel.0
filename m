From: robh@kernel.org (Rob Herring)
Date: Mon, 5 Mar 2018 18:00:17 -0600
Subject: [PATCH v2] arm: dts: zynq: Add Digilent Zybo Z7 board
In-Reply-To: <20180228022552.9088-1-nobuhiro.iwamatsu@cybertrust.co.jp>
References: <20180228022552.9088-1-nobuhiro.iwamatsu@cybertrust.co.jp>
Message-ID: <20180306000017.y444gu3aie2f3c2k@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 28, 2018 at 11:25:52AM +0900, Nobuhiro Iwamatsu wrote:
> This add a DTS for the Digilent Zybo Z7 board.
> This board is the successor board of Zybo, these are almost the same except
> for ps-clk-frequency specifications.
> 
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu@cybertrust.co.jp>
> ---
>  v2:
>    - Fix SPDX format
>    - Rebase linux-xlnx/tree/zynq/dt
>    - Add digilent,zynq-zybo-z7 compatible string
>    - Fix memory node.
> 
>  Documentation/devicetree/bindings/arm/xilinx.txt |  3 ++
>  arch/arm/boot/dts/Makefile                       |  3 +-
>  arch/arm/boot/dts/zynq-zybo-z7.dts               | 58 ++++++++++++++++++++++++
>  3 files changed, 63 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/zynq-zybo-z7.dts

Reviewed-by: Rob Herring <robh@kernel.org>
