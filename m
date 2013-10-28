From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Mon, 28 Oct 2013 22:16:49 +0100
Subject: [PATCH 1/2] mmc: arasan: Add driver for Arasan SDHCI
In-Reply-To: <1381864085-8806-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1381864085-8806-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1587218.cW45zK0ty2@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Soren,

On Tuesday 15 of October 2013 12:08:04 Soren Brinkmann wrote:
> Add a driver for Arasan's SDHCI controller core.
> 
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> ---
>  .../devicetree/bindings/mmc/arasan,sdhci.txt       |  23 +++
>  MAINTAINERS                                        |   1 +
>  drivers/mmc/host/Kconfig                           |  12 ++
>  drivers/mmc/host/Makefile                          |   1 +
>  drivers/mmc/host/sdhci-of-arasan.c                 | 224
> +++++++++++++++++++++ 5 files changed, 261 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/mmc/arasan,sdhci.txt create mode
> 100644 drivers/mmc/host/sdhci-of-arasan.c
> 
> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt new file mode
> 100644
> index 000000000000..20f0fc25e270
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> @@ -0,0 +1,23 @@
> +Device Tree Bindings for the Arasan SDCHI Controller
> +
> +  The bindings follow the mmc[1] and the clock bindings[2]. Only
> deviations are +  documented here.
> +
> +  [1] Documentation/devicetree/bindings/mmc/mmc.txt
> +  [2] Documentation/devicetree/bindings/clock/clock-bindings.txt
> +
> +Required Properties:

According to the example below, the list of required properties lacks 
interrupt-related properties.

Except this minor issue, the binding is trivial and looks fine to me.

Best regards,
Tomasz
