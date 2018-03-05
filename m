From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 5 Mar 2018 13:03:05 +0100
Subject: [PATCH v2] arm: dts: zynq: Add Digilent Zybo Z7 board
In-Reply-To: <20180228022552.9088-1-nobuhiro.iwamatsu@cybertrust.co.jp>
References: <20180228022552.9088-1-nobuhiro.iwamatsu@cybertrust.co.jp>
Message-ID: <045eae47-49bb-971c-6e83-ad1e436b5848@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28.2.2018 03:25, Nobuhiro Iwamatsu wrote:
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

I can't see any issue with this patch that's why will apply when
previous series is acked.

Thanks,
Michal
