From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 10 Aug 2015 13:56:40 +0100
Subject: [PATCH] mfd: atmel-hlcdc: Add support for new SoCs
In-Reply-To: <1438361154-10596-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1438361154-10596-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20150810125640.GG3249@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 31 Jul 2015, Boris Brezillon wrote:

> Add the compatible strings for the at91sam9x5, at91sam9n12, sama5d4 and
> sama5d2 SoCs.
> Update the documentation accordingly.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
>  Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt | 4 ++++
>  drivers/mfd/atmel-hlcdc.c                             | 4 ++++
>  2 files changed, 8 insertions(+)

I'll accept this time, but next time please send C and binding patches
separately, as per [0].

Applied, thanks.

[0] Documentation/devicetree/bindings/submitting-patches.txt

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
