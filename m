From: alexander.stein@systec-electronic.com (Alexander Stein)
Date: Mon, 08 Aug 2016 10:57:04 +0200
Subject: [Patch v3 10/11] driver/edac/layerscape_edac: Add Layerscape EDAC
 support
In-Reply-To: <1470351518-22404-11-git-send-email-york.sun@nxp.com>
References: <1470351518-22404-1-git-send-email-york.sun@nxp.com>
 <1470351518-22404-11-git-send-email-york.sun@nxp.com>
Message-ID: <19101224.m7ryErTDyD@ws-stein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 04 August 2016 15:58:35, York Sun wrote:
> Add DDR EDAC for ARM-based compatible controllers. Both big-endian
> and little-endian are supported.
> 
> Signed-off-by: York Sun <york.sun@nxp.com>
> 
> ---
> Change log
>   v3: no change
>   v2: Create new driver using shared DDR object
> 
>  arch/arm64/Kconfig.platforms           |  1 +
>  arch/{arm => arm64}/include/asm/edac.h | 21 +++++------
>  arch/arm64/include/asm/irq.h           |  4 ++
>  drivers/edac/Kconfig                   |  7 ++++
>  drivers/edac/Makefile                  |  3 ++
>  drivers/edac/fsl_ddr_edac.c            |  1 +
>  drivers/edac/layerscape_edac.c         | 67
> ++++++++++++++++++++++++++++++++++ 7 files changed, 92 insertions(+), 12
> deletions(-)
>  copy arch/{arm => arm64}/include/asm/edac.h (79%)
>  create mode 100644 drivers/edac/layerscape_edac.c

This only adds EDAC support for ARM64. What would be necessary for ARM 
support, e.g. LS1021A?

Best regards,
Alexander
