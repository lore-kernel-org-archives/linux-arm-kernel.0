From: jg1.han@samsung.com (Jingoo Han)
Date: Thu, 19 Dec 2013 10:04:26 +0900
Subject: [PATCH V2 1/7] PCI: imx6: Make reset-gpio optional
In-Reply-To: <1386885004-10252-1-git-send-email-marex@denx.de>
References: <1386885004-10252-1-git-send-email-marex@denx.de>
Message-ID: <001e01cefc56$438a7ee0$ca9f7ca0$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, December 13, 2013 6:50 AM, Marek Vasut wrote:
> 
> Some boards do not have a PCIe reset GPIO. To avoid probe
> failure on these boards, make the reset GPIO optional as
> well.
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
>  .../devicetree/bindings/pci/designware-pcie.txt    |  2 ++
>  drivers/pci/host/pci-imx6.c                        | 29 +++++++++++-----------
>  2 files changed, 17 insertions(+), 14 deletions(-)
