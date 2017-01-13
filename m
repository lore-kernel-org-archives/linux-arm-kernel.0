From: Joao.Pinto@synopsys.com (Joao Pinto)
Date: Fri, 13 Jan 2017 16:35:03 +0000
Subject: [PATCH 04/37] PCI: dwc: designware: Move the register defines to
 designware header file
In-Reply-To: <1484216786-17292-5-git-send-email-kishon@ti.com>
References: <1484216786-17292-1-git-send-email-kishon@ti.com>
 <1484216786-17292-5-git-send-email-kishon@ti.com>
Message-ID: <0913dcb3-ecb8-b926-981d-f5d3baa9d8b7@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


?s 10:25 AM de 1/12/2017, Kishon Vijay Abraham I escreveu:
> No functional change. Move the register defines and other macros from
> pcie-designware.c to pcie-designware.h. This is in preparation to
> split the pcie-designware.c file into designware core file and host
> specific file.
> 
> While at that also fix a checkpatch warning.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/dwc/pcie-designware.c |   70 ------------------------------------
>  drivers/pci/dwc/pcie-designware.h |   71 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 71 insertions(+), 70 deletions(-)
> 
> diff --git a/drivers/pci/dwc/pcie-designware.c b/drivers/pci/dwc/pcie-designware.c
> index d68bc7b..0b928dc 100644
> --- a/drivers/pci/dwc/pcie-designware.c
> +++ b/drivers/pci/dwc/pcie-designware.c
> @@ -25,76 +25,6 @@
>  
>  #include "pcie-designware.h"

Make sense.

Reviewed-By: Joao Pinto <jpinto@synopsys.com>
