From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 10 May 2016 12:28:39 +0200
Subject: [PATCH] mmc: sdhci-st: correct name of sd-uhs-sdr50 property
In-Reply-To: <1462839264-13300-1-git-send-email-horms+renesas@verge.net.au>
References: <1462839264-13300-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAPDyKFovKxGDnnyKAWjpjTN=7XB5sbTe+gyh2OTSRQ=bmnJTFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 May 2016 at 02:14, Simon Horman <horms+renesas@verge.net.au> wrote:
> Correct what appears to be a typo in the name of the sd-uhs-sdr50.
>
> Also fix mixed tab/space indentation.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  Documentation/devicetree/bindings/mmc/sdhci-st.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-st.txt b/Documentation/devicetree/bindings/mmc/sdhci-st.txt
> index 18d950df2749..88faa91125bf 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-st.txt
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-st.txt
> @@ -38,7 +38,7 @@ Optional properties:
>  - bus-width:           Number of data lines.
>                         See:  Documentation/devicetree/bindings/mmc/mmc.txt.
>
> -- max-frequency:       Can be 200MHz, 100Mz or 50MHz (default) and used for
> +- max-frequency:       Can be 200MHz, 100Mz or 50MHz (default) and used for
>                         configuring the CCONFIG3 in the mmcss.
>                         See:  Documentation/devicetree/bindings/mmc/mmc.txt.
>
> @@ -48,7 +48,7 @@ Optional properties:
>  - vqmmc-supply:                Phandle to the regulator dt node, mentioned as the vcc/vdd
>                         supply in eMMC/SD specs.
>
> -- sd-uhs--sdr50:       To enable the SDR50 in the mmcss.
> +- sd-uhs-sdr50:        To enable the SDR50 in the mmcss.
>                         See:  Documentation/devicetree/bindings/mmc/mmc.txt.
>
>  - sd-uhs-sdr104:       To enable the SDR104 in the mmcss.
> --
> 2.1.4
>
