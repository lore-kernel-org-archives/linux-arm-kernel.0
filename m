From: galak@codeaurora.org (Kumar Gala)
Date: Tue, 29 Oct 2013 12:21:52 -0500
Subject: [PATCH 1/3] dma: imx-sdma: Add ssi dual fifo script support
In-Reply-To: <9ed025d4e98f716ba80b27acaaa98f43ad3bd75a.1383047327.git.b42378@freescale.com>
References: <cover.1383047327.git.b42378@freescale.com>
 <9ed025d4e98f716ba80b27acaaa98f43ad3bd75a.1383047327.git.b42378@freescale.com>
Message-ID: <4648FA57-F1B4-4341-A536-BAA43364165D@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Oct 29, 2013, at 7:33 AM, Nicolin Chen wrote:

> There's a script for SSI missing in current sdma script list. Thus add it.
> This script would allow SSI use its dual fifo mode to transimit/receive
> data without occasional hardware underrun/overrun.
> 
> This patch also fixed a counting error for total number of scripts.
> 
> Signed-off-by: Nicolin Chen <b42378@freescale.com>
> ---
> Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt | 1 +
> drivers/dma/imx-sdma.c                                 | 6 +++++-
> include/linux/platform_data/dma-imx-sdma.h             | 2 ++
> include/linux/platform_data/dma-imx.h                  | 1 +
> 4 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt b/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
> index 4fa814d..3b933c5 100644
> --- a/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
> +++ b/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
> @@ -42,6 +42,7 @@ The full ID of peripheral types can be found below.
> 	19	IPU Memory
> 	20	ASRC
> 	21	ESAI
> +	22	SSI Dual FIFO
> 
> The third cell specifies the transfer priority as below.

For the DT-Binding portion:

Acked-by: Kumar Gala <galak@codeaurora.org>

- k

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
