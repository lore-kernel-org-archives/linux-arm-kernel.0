From: robh@kernel.org (Rob Herring)
Date: Mon, 25 Apr 2016 07:51:13 -0500
Subject: [PATCH v2 3/5] serial: mxs-auart: Use generic uart-has-rtscts DT
 property
In-Reply-To: <1461338544-29568-4-git-send-email-geert+renesas@glider.be>
References: <1461338544-29568-1-git-send-email-geert+renesas@glider.be>
 <1461338544-29568-4-git-send-email-geert+renesas@glider.be>
Message-ID: <20160425125113.GA3859@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 22, 2016 at 05:22:22PM +0200, Geert Uytterhoeven wrote:
> Convert the Freescale MXS AUART driver from using the vendor-specific
> "fsl,uart-has-rtscts" to the generic "uart-has-rtscts" DT property, as
> documented by the Generic Serial DT Bindings.
> 
> The old vendor-specific property is still recognized by the driver for
> backwards compatibility, but it is deprecated.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v2:
>   - No changes.
> 
>  Documentation/devicetree/bindings/serial/fsl-mxs-auart.txt | 2 +-
>  drivers/tty/serial/mxs-auart.c                             | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
