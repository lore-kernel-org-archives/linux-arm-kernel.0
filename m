From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 2 Jul 2018 15:17:32 +0200
Subject: [PATCH v3 0/2] mmc: sdhci-of-arasan: workaround for broken clocks
In-Reply-To: <cover.1529493667.git.h.grohne@intenta.de>
References: <20180615081830.zrgx6arwn6ga27gu@laureti-dev>
 <cover.1529493667.git.h.grohne@intenta.de>
Message-ID: <CAPDyKFp518uXGyiXL2_ejzHnyCN0RSQDvjCDxNg+_pqw9VANUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 June 2018 at 13:32, Helmut Grohne <h.grohne@intenta.de> wrote:
> This patch series works around the internal clock indicating stability too
> quickly to operate. It manifests itself as:
>
>     mmc0: error -84 whilst initialising SD card
>
> Changes since v2:
>  * Ulf Hansson requested splitting the patch in accordance with
>    Documentation/devicetree/bindings/submitting-patches.txt. Also update
>    recipient list accordingly.
>  * Added Acked-by from Adrian Hunter.
>
> Helmut Grohne (2):
>   dt-bindings: mmc: broken clock stable indicator on arasan controllers
>   mmc: sdhci-of-arasan: Add quirk for unstable clocks
>
>  Documentation/devicetree/bindings/mmc/arasan,sdhci.txt |  2 ++
>  drivers/mmc/host/sdhci-of-arasan.c                     | 16 ++++++++++++++++
>  2 files changed, 18 insertions(+)
>
> --
> 2.11.0
>

Thanks, applied for next!

Kind regards
Uffe
