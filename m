From: robh@kernel.org (Rob Herring)
Date: Mon, 27 Feb 2017 13:42:53 -0600
Subject: [RESEND PATCH v5 1/4] PCI: imx6: Add code to support i.MX7D
In-Reply-To: <20170220160900.7014-2-andrew.smirnov@gmail.com>
References: <20170220160900.7014-1-andrew.smirnov@gmail.com>
 <20170220160900.7014-2-andrew.smirnov@gmail.com>
Message-ID: <20170227194253.i7vcouppxr62sgh5@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 20, 2017 at 08:08:57AM -0800, Andrey Smirnov wrote:
> Add various bits of code needed to support i.MX7D variant of the IP.
> 
> Cc: yurovsky at gmail.com
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: devicetree at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  .../devicetree/bindings/pci/fsl,imx6q-pcie.txt     |  13 ++-

I guess the conclusion of the discussion is this is fine, so:

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/pci/host/pci-imx6.c                        | 121 ++++++++++++++++-----
>  include/linux/mfd/syscon/imx7-iomuxc-gpr.h         |   4 +
>  3 files changed, 112 insertions(+), 26 deletions(-)
