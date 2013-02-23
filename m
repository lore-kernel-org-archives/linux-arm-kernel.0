From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sun, 24 Feb 2013 01:18:38 +0400
Subject: [PATCH 1/2] Drivers: w1: mxc_w1, Add support for DT
In-Reply-To: <1361640958-1876-1-git-send-email-mpa@pengutronix.de>
References: <1361640958-1876-1-git-send-email-mpa@pengutronix.de>
Message-ID: <5129322E.9030400@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 23-02-2013 21:35, Markus Pargmann wrote:

> Add devicetree support for mxc_w1 driver.

> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>   Documentation/devicetree/bindings/w1/fsl,mxc-w1.txt | 13 +++++++++++++
>   drivers/w1/masters/mxc_w1.c                         |  7 +++++++
>   2 files changed, 20 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/w1/fsl,mxc-w1.txt

> diff --git a/Documentation/devicetree/bindings/w1/fsl,mxc-w1.txt b/Documentation/devicetree/bindings/w1/fsl,mxc-w1.txt
> new file mode 100644
> index 0000000..686ced4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/w1/fsl,mxc-w1.txt
> @@ -0,0 +1,13 @@
> +Freescale driver for Dalla's 1-wire bus master on imx chips

    You meant "Dallas'".

WBR, Sergei
