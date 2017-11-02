From: scott.branden@broadcom.com (Scott Branden)
Date: Thu, 2 Nov 2017 12:35:24 -0700
Subject: [PATCH 0/2] hwrng: iproc-rng200: Add support for BCM7278
In-Reply-To: <20171101232006.3943-1-f.fainelli@gmail.com>
References: <20171101232006.3943-1-f.fainelli@gmail.com>
Message-ID: <b268ce8a-ac98-47a5-9fa1-555bcb1302dd@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch series looks fine.


On 17-11-01 04:20 PM, Florian Fainelli wrote:
> Hi,
>
> This patch series adds support for the RNG200 block found on the BCM7278 SoC.
> This requires us to update the compatible string (and associated binding
> document) as well as the Kconfig option to make that driver selectable with
> ARCH_BRCMSTB gating the enabling of such SoCs.
>
> Thank you
>
> Florian Fainelli (2):
>    dt-bindings: rng: Document BCM7278 RNG200 compatible
>    hwrng: iproc-rng200: Add support for BCM7278
>
>   Documentation/devicetree/bindings/rng/brcm,iproc-rng200.txt | 4 +++-
>   drivers/char/hw_random/Kconfig                              | 6 +++---
>   drivers/char/hw_random/iproc-rng200.c                       | 1 +
>   3 files changed, 7 insertions(+), 4 deletions(-)
>
Acked-by: Scott Branden <scott.branden@broadcom.com>
