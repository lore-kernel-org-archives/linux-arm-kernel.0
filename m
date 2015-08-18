From: dinguyen@opensource.altera.com (Dinh Nguyen)
Date: Tue, 18 Aug 2015 11:04:32 -0500
Subject: [PATCHv2] arm64: dts: Add base stratix 10 dtsi
In-Reply-To: <1439308127-7412-1-git-send-email-dinguyen@opensource.altera.com>
References: <1439308127-7412-1-git-send-email-dinguyen@opensource.altera.com>
Message-ID: <alpine.DEB.2.02.1508181103230.23339@linux-builds1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 11 Aug 2015, dinguyen at opensource.altera.com wrote:

> From: Dinh Nguyen <dinguyen@opensource.altera.com>
> 
> Add the base DTS for Altera's SoCFPGA Stratix 10 platform.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
> ---
> v2: use interrupt-affinity for pmu node
> ---
>  arch/arm64/Kconfig                                 |   5 +
>  arch/arm64/boot/dts/Makefile                       |   1 +
>  arch/arm64/boot/dts/altera/Makefile                |   5 +
>  arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi  | 358 +++++++++++++++++++++
>  .../boot/dts/altera/socfpga_stratix10_socdk.dts    |  38 +++
>  arch/arm64/configs/defconfig                       |   1 +
>  6 files changed, 408 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/altera/Makefile
>  create mode 100644 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
>  create mode 100644 arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
> 

Soft ping on this pach?

BR,
Dinh
