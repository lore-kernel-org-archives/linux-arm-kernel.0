From: rsahu@apm.com (Rameshwar Sahu)
Date: Wed, 4 Feb 2015 15:08:31 +0530
Subject: [PATCH v5 0/3] dmaengine: APM X-Gene SoC DMA engine driver support
In-Reply-To: <1422968107-23125-1-git-send-email-rsahu@apm.com>
References: <1422968107-23125-1-git-send-email-rsahu@apm.com>
Message-ID: <CAFd313zotqiG7rVDVthwRp=XiCOcgsRwQSmwpXyb8coSKnZYFg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

Can you please review this patch set.


Thanks,
with regards,
Ram


On Tue, Feb 3, 2015 at 6:25 PM, Rameshwar Prasad Sahu <rsahu@apm.com> wrote:
> This patch set implements the APM X-Gene SoC DMA driver
> support to offload the DMA operations such as memory copy(memcpy),
> scatter gathering.
>
> v5 changes:
>         1. Minor changes in coding style.
>         2. Added DMA_CTRL_ACK flag initialization
> v4 changes:
>         1. Fixed dma-ranges property on DTS.
>
> Signed-off-by: Rameshwar Prasad Sahu <rsahu@apm.com>
> Signed-off-by: Loc Ho <lho@apm.com>
> ---
>
> Rameshwar Prasad Sahu (3):
>   dmaengine: Add support for APM X-Gene SoC DMA engine driver
>   arm64: dts: Add APM X-Gene DMA device and DMA clock DTS nodes
>   Documentation: dma: Add APM X-Gene SoC DMA engine driver documentation
>
>  .../devicetree/bindings/dma/apm-xgene-dma.txt      |   49 +
>  arch/arm64/boot/dts/apm/apm-storm.dtsi             |   26 +
>  drivers/dma/Kconfig                                |    8 +
>  drivers/dma/Makefile                               |    1 +
>  drivers/dma/xgene-dma.c                            | 1597 ++++++++++++++++++++
>  5 files changed, 1681 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/apm-xgene-dma.txt
>  create mode 100755 drivers/dma/xgene-dma.c
>
> --
> 1.8.2.1
>
