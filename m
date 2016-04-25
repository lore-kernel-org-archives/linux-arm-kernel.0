From: robh@kernel.org (Rob Herring)
Date: Mon, 25 Apr 2016 07:52:44 -0500
Subject: [PATCH v2 5/5] serial: sirf: Use generic uart-has-rtscts DT
 property
In-Reply-To: <1461338544-29568-6-git-send-email-geert+renesas@glider.be>
References: <1461338544-29568-1-git-send-email-geert+renesas@glider.be>
 <1461338544-29568-6-git-send-email-geert+renesas@glider.be>
Message-ID: <20160425125244.GA4156@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 22, 2016 at 05:22:24PM +0200, Geert Uytterhoeven wrote:
> Convert the SiRF UART driver from using the vendor-specific
> "sirf,uart-has-rtscts" to the generic "uart-has-rtscts" DT property, as
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
>  Documentation/devicetree/bindings/serial/sirf-uart.txt | 8 ++++----
>  drivers/tty/serial/sirfsoc_uart.c                      | 3 ++-
>  2 files changed, 6 insertions(+), 5 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
