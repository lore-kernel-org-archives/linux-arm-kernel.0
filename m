From: dinguyen@kernel.org (Dinh Nguyen)
Date: Wed, 16 May 2018 08:36:32 -0500
Subject: [PATCHv3] arm64: dts: stratix10: Add QSPI support for Stratix10
In-Reply-To: <1526423187-27521-1-git-send-email-thor.thayer@linux.intel.com>
References: <1526423187-27521-1-git-send-email-thor.thayer@linux.intel.com>
Message-ID: <d6175958-41a4-8d5c-2cba-ff6bc9c74a4e@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05/15/2018 05:26 PM, thor.thayer at linux.intel.com wrote:
> From: Thor Thayer <thor.thayer@linux.intel.com>
> 
> Add qspi_clock
>    The qspi_clk frequency is updated by U-Boot before starting Linux.
> Add QSPI interface node.
> Add QSPI flash memory child node.
>    Setup the QSPI memory in 2 partitions.
> 
> Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
> ---
> v2  s/_/-/ in qspi-clk
>     rename flash node.
>     use partition child node notation
> v3  remove unused bus-num node
>     use device id from table (n25q00a)
> ---
>  arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi  | 21 +++++++++++++
>  .../boot/dts/altera/socfpga_stratix10_socdk.dts    | 35 ++++++++++++++++++++++
>  2 files changed, 56 insertions(+)
> 

Applied!

Thanks,
Dinh
