From: dinguyen@opensource.altera.com (Dinh Nguyen)
Date: Tue, 18 Oct 2016 16:03:01 -0500
Subject: [PATCH 3/3] ARM: socfpga: defconfig: enable qspi
In-Reply-To: <20161018074304.6744-3-s.trumtrar@pengutronix.de>
References: <20161018074304.6744-1-s.trumtrar@pengutronix.de>
 <20161018074304.6744-3-s.trumtrar@pengutronix.de>
Message-ID: <alpine.DEB.2.02.1610181600570.27375@linux-builds1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 18 Oct 2016, Steffen Trumtrar wrote:

> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> ---
>  arch/arm/configs/socfpga_defconfig | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/configs/socfpga_defconfig b/arch/arm/configs/socfpga_defconfig
> index 9f84be5b3ac5..466050663c86 100644
> --- a/arch/arm/configs/socfpga_defconfig
> +++ b/arch/arm/configs/socfpga_defconfig

Thanks Steffen, all patches applied. I'll fixup the commit header for the DTS
patches. The arm-soc maintainers prefer the DTS patches to be:

"ARM: dts: <platform>"

BR,
Dinh
