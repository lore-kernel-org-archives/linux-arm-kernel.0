From: jg1.han@samsung.com (Jingoo Han)
Date: Thu, 19 Dec 2013 10:11:26 +0900
Subject: [PATCH V2 3/7] PCI: imx6: Split away the PHY reset
In-Reply-To: <1386757818-5154-3-git-send-email-marex@denx.de>
References: <1386757818-5154-1-git-send-email-marex@denx.de>
 <1386757818-5154-3-git-send-email-marex@denx.de>
Message-ID: <001f01cefc57$3d77d1a0$b86774e0$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, December 11, 2013 7:30 PM, Marek Vasut wrote:
> 
> Split the PCIe PHY reset from the link up function to make
> the code a little more structured.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Frank Li <lznuaa@gmail.com>
> Cc: Harro Haan <hrhaan@gmail.com>
> Cc: Jingoo Han <jg1.han@samsung.com>
> Cc: Mohit KUMAR <Mohit.KUMAR@st.com>
> Cc: Pratyush Anand <pratyush.anand@st.com>
> Cc: Richard Zhu <r65037@freescale.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Sean Cross <xobs@kosagi.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Siva Reddy Kallam <siva.kallam@samsung.com>
> Cc: Srikanth T Shivanand <ts.srikanth@samsung.com>
> Cc: Tim Harvey <tharvey@gateworks.com>
> Cc: Troy Kisky <troy.kisky@boundarydevices.com>
> Cc: Yinghai Lu <yinghai@kernel.org>

Reviewed-by: Jingoo Han <jg1.han@samsung.com>

Best regards,
Jingoo Han

> ---
>  drivers/pci/host/pci-imx6.c | 35 +++++++++++++++++++----------------
>  1 file changed, 19 insertions(+), 16 deletions(-)
> 
> V2: Drop unused 'temp' variable.
