From: dinguyen@opensource.altera.com (Dinh Nguyen)
Date: Tue, 8 Mar 2016 08:45:26 -0600
Subject: [PATCHv2 10/11] ARM: socfpga: Enable Arria10 L2 cache ECC on
 startup
In-Reply-To: <1457379787-8327-11-git-send-email-tthayer@opensource.altera.com>
References: <1457379787-8327-1-git-send-email-tthayer@opensource.altera.com>
 <1457379787-8327-11-git-send-email-tthayer@opensource.altera.com>
Message-ID: <56DEE586.8010102@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/07/2016 01:43 PM, tthayer at opensource.altera.com wrote:
> From: Thor Thayer <tthayer@opensource.altera.com>
> 
> Enable ECC for Arria10 L2 cache on machine startup. The ECC has to be
> enabled before data is stored in memory otherwise the ECC will fail
> on reads.
> Use DT_MACHINE to select Arria10 L2 cache function.
> 
> Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
> ---
> v2: Split into 2 separate functions selected with DT_MACHINE.
> ---
>  arch/arm/mach-socfpga/core.h     |    1 +
>  arch/arm/mach-socfpga/l2_cache.c |   49 ++++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-socfpga/socfpga.c  |   10 +++++++-
>  3 files changed, 59 insertions(+), 1 deletion(-)
> 

Acked-by: Dinh Nguyen <dinguyen@opensource.altera.com>

Thanks,
Dinh
