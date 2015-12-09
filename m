From: rsahu@apm.com (Rameshwar Sahu)
Date: Wed, 9 Dec 2015 13:55:55 +0530
Subject: [PATCH v2 0/3] dmaengine: Add supports for APM X-Gene SoC CRC32C
 accerlerator driver
In-Reply-To: <1447665169-14003-1-git-send-email-rsahu@apm.com>
References: <rsahu@apm.com> <1447665169-14003-1-git-send-email-rsahu@apm.com>
Message-ID: <CAFd313yzBgWhTD2+Lz+RsdziAuc2kdZPS1L2FExET5sLirs_DQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Nov 16, 2015 at 2:42 PM,  <rsahu@apm.com> wrote:
> From: Rameshwar Prasad Sahu <rsahu@apm.com>
>
> This patch implements support for APM X-Gene SoC CRC32C h/w accelerator driver
> and adds CRC32C computations support in dmaengine framework. APM X-Gene SoC has
> DMA engine capable of performing CRC32C computations.
>
> v2 changes:
>         1. Added helper function in dmaengine framework
>         2. Documented CRC32C support in Documentations/dmaengine/provider.txt
>         3. Fixed algo name
>         4. Fixed coding style issues
>
> Signed-off-by: Rameshwar Prasad Sahu <rsahu@apm.com>
> ---
>
> Rameshwar Prasad Sahu (3):
>   dmaengine: Add support for new feature CRC32C computations
>   dmaengine: xgene-dma: Add support for CRC32C computations via DMA
>     engine
>   Crypto: Add support for APM X-Gene SoC CRC32C h/w accelerator driver
>
>  Documentation/dmaengine/provider.txt |    3 +
>  drivers/crypto/Kconfig               |    8 +
>  drivers/crypto/Makefile              |    1 +
>  drivers/crypto/xgene-crc32c.c        |  234 +++++++++++++++++++++++++
>  drivers/dma/dmaengine.c              |    2 +
>  drivers/dma/xgene-dma.c              |  314 ++++++++++++++++++++++++++++++++--
>  include/linux/dmaengine.h            |   13 ++
>  7 files changed, 560 insertions(+), 15 deletions(-)
>  create mode 100755 drivers/crypto/xgene-crc32c.c

Any comments on above patch ??
