From: robh@kernel.org (Rob Herring)
Date: Mon, 25 Apr 2016 07:50:44 -0500
Subject: [PATCH v2 2/5] serial: imx: Use generic uart-has-rtscts DT
 property
In-Reply-To: <1461338544-29568-3-git-send-email-geert+renesas@glider.be>
References: <1461338544-29568-1-git-send-email-geert+renesas@glider.be>
 <1461338544-29568-3-git-send-email-geert+renesas@glider.be>
Message-ID: <20160425125043.GA3200@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 22, 2016 at 05:22:21PM +0200, Geert Uytterhoeven wrote:
> Convert the Freescale IMX UART driver from using the vendor-specific
> "fsl,uart-has-rtscts" to the generic "uart-has-rtscts" DT property, as
> documented by the Generic Serial DT Bindings.
> 
> The old vendor-specific property is still recognized by the driver for
> backwards compatibility, but deprecated.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v2:
>   - No changes.
> 
>  Documentation/devicetree/bindings/serial/fsl-imx-uart.txt | 4 ++--
>  drivers/tty/serial/imx.c                                  | 3 ++-
>  2 files changed, 4 insertions(+), 3 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
