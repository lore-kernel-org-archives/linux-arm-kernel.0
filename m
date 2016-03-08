From: dinguyen@opensource.altera.com (Dinh Nguyen)
Date: Tue, 8 Mar 2016 15:18:26 -0600
Subject: [PATCH] ARM: socfpga: dts: Add missing clock and interrupt fields
 for Arria10 DMA
In-Reply-To: <1457456571-25541-1-git-send-email-grmoore@opensource.altera.com>
References: <1457456571-25541-1-git-send-email-grmoore@opensource.altera.com>
Message-ID: <alpine.DEB.2.02.1603081517350.12664@linux-builds1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 8 Mar 2016, Graham Moore wrote:

> The PL330 DMA driver will not load on Arria10 without devicetree entries
> for clocks and clock_names.  This patch adds those entries.  It also adds
> the ninth interrupt, which is required for error detection.
> 
> Signed-off-by: Graham Moore <grmoore@opensource.altera.com>
> ---
>  arch/arm/boot/dts/socfpga_arria10.dtsi | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Applied.

Thanks,
Dinh
