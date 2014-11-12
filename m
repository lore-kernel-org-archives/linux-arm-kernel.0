From: dinguyen@opensource.altera.com (Dinh Nguyen)
Date: Wed, 12 Nov 2014 01:32:03 -0600
Subject: [PATCHv5 1/5] arm: socfpga: Enable L2 Cache ECC on startup.
In-Reply-To: <1415751263-1830-2-git-send-email-tthayer@opensource.altera.com>
References: <1415751263-1830-1-git-send-email-tthayer@opensource.altera.com>
 <1415751263-1830-2-git-send-email-tthayer@opensource.altera.com>
Message-ID: <54630CF3.6020409@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/11/14, 6:14 PM, tthayer at opensource.altera.com wrote:
> From: Thor Thayer <tthayer@opensource.altera.com>
> 
> This patch enables the ECC for L2 cache on machine
> startup.  The ECC has to be enabled before data is
> is stored in memory otherwise the ECC will fail on
> reads.
> 
> Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
> ---
> v2: Split OCRAM initialization into separate patch.
> 
> v3/4: No change
> 
> v5: Remove l2cache.h, use io.h instead of clk-provider.h
>     Make copyright header inclusive. Remove MAINTAINERS entry.
> ---
>  arch/arm/mach-socfpga/Makefile   |    1 +
>  arch/arm/mach-socfpga/core.h     |    2 ++
>  arch/arm/mach-socfpga/l2_cache.c |   41 ++++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-socfpga/socfpga.c  |    4 +++-
>  4 files changed, 47 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/mach-socfpga/l2_cache.c
> 

Acked-by: Dinh Nguyen <dinguyen@opensource.altera.com>
