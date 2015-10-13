From: dinguyen@opensource.altera.com (Dinh Nguyen)
Date: Tue, 13 Oct 2015 14:51:28 -0500
Subject: [PATCH v2] ARM: socfpga: dts: add fpga manager
In-Reply-To: <1444765139-2040-1-git-send-email-atull@opensource.altera.com>
References: <1444765139-2040-1-git-send-email-atull@opensource.altera.com>
Message-ID: <alpine.DEB.2.02.1510131450480.4441@linux-builds1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 13 Oct 2015, atull at opensource.altera.com wrote:

> From: Alan Tull <atull@opensource.altera.com>
> 
> Add FPGA manager to device tree for SoCFPGA.
> 
> Signed-off-by: Alan Tull <atull@opensource.altera.com>
> ---
> v2: Remove 0x after @
>     No caps in hex numbers
>     renamed hps_0_fpgamgr to fpgamgr0
>     move node to be in alpha order by node name
> ---
>  arch/arm/boot/dts/socfpga.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Applied!

Thanks,
Dinh
