From: rsahu@apm.com (Rameshwar Sahu)
Date: Thu, 30 Jul 2015 17:50:58 +0530
Subject: [PATCH v1 0/4] Crypto: tcrypt: Add test case for APM X-Gene SoC
 CRC32C algo
In-Reply-To: <1438258268-3099-1-git-send-email-rsahu@apm.com>
References: <1438258268-3099-1-git-send-email-rsahu@apm.com>
Message-ID: <CAFd313wpsfYtK=fZ4Qin1y8vtX7-tgAEPPBtVDqAW8wxtisgAw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

On Thu, Jul 30, 2015 at 5:41 PM, Rameshwar Prasad Sahu <rsahu@apm.com> wrote:
> This patch adds test case for APM X-Gene SoC CRC32C algorithm.

Please discard this patch description and subject line in this cover
letter, I have resent it again.

Thanks,
Ram

>
> Signed-off-by: Rameshwar Prasad Sahu <rsahu@apm.com>
> ---
>
> Rameshwar Prasad Sahu (4):
>   dmaengine: Add support for new feature CRC32C
>   dmaengine: xgene-dma: Add support for CRC32C calculation via DMA
>     engine
>   Crypto: Add support for APM X-Gene SoC CRC32C h/w accelerator driver
>   Crypto: tcrypt: Add test case for APM X-Gene SoC CRC32C algo
>
>  crypto/tcrypt.c               |   4 +
>  crypto/testmgr.c              |   9 ++
>  drivers/crypto/Kconfig        |   8 ++
>  drivers/crypto/Makefile       |   1 +
>  drivers/crypto/xgene-crc32c.c | 244 ++++++++++++++++++++++++++++++++
>  drivers/dma/dmaengine.c       |   2 +
>  drivers/dma/xgene-dma.c       | 317 ++++++++++++++++++++++++++++++++++++++++--
>  include/linux/dmaengine.h     |   5 +
>  8 files changed, 575 insertions(+), 15 deletions(-)
>  create mode 100755 drivers/crypto/xgene-crc32c.c
>
> --
> 1.8.2.1
