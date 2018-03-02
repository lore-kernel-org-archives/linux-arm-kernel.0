From: robh@kernel.org (Rob Herring)
Date: Fri, 2 Mar 2018 12:13:28 -0600
Subject: [PATCH v2 1/5] arm: zynq: Add Xilinx cc108 board
In-Reply-To: <eb2fec632fcb7fbfed39dcbeae92b38a98518618.1519398009.git.michal.simek@xilinx.com>
References: <cover.1519398009.git.michal.simek@xilinx.com>
 <eb2fec632fcb7fbfed39dcbeae92b38a98518618.1519398009.git.michal.simek@xilinx.com>
Message-ID: <20180302181328.wbgnnw2jsuorfahi@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 23, 2018 at 04:00:19PM +0100, Michal Simek wrote:
> The board contains 7z010 with 512MB memory, ethernet, qspi, uart, usbs
> and sd. But board is not supporting booting from sd card.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
> Changes in v2:
> - Record compatible string to xilinx.txt
> 
>  Documentation/devicetree/bindings/arm/xilinx.txt |  5 ++
>  arch/arm/boot/dts/Makefile                       |  1 +
>  arch/arm/boot/dts/zynq-cc108.dts                 | 75 ++++++++++++++++++++++++
>  3 files changed, 81 insertions(+)
>  create mode 100644 arch/arm/boot/dts/zynq-cc108.dts

Reviewed-by: Rob Herring <robh@kernel.org>
