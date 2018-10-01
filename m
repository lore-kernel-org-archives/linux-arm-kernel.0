From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 1 Oct 2018 21:23:39 +0900
Subject: [PATCH v3 0/2] dmaengine: add UniPhier MIO DMAC driver
In-Reply-To: <1536799869-10643-1-git-send-email-yamada.masahiro@socionext.com>
References: <1536799869-10643-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CAK7LNAQsGKSnBmrfEAwgoieizho8WCif_M3NuxtSe3+6Qo6vxg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,


2018?9?13?(?) 9:52 Masahiro Yamada <yamada.masahiro@socionext.com>:
>
> 1/2: DT-binding
> 2/2: driver


If there is no more comment,
is this series applicable for v4.20-rc1 ?


>
> Masahiro Yamada (2):
>   dt-bindings: dmaengine: add DT binding for UniPhier MIO DMAC
>   dmaengine: uniphier-mdmac: add UniPhier MIO DMAC driver
>
>  .../devicetree/bindings/dma/uniphier-mio-dmac.txt  |  25 ++
>  MAINTAINERS                                        |   1 +
>  drivers/dma/Kconfig                                |  11 +
>  drivers/dma/Makefile                               |   1 +
>  drivers/dma/uniphier-mdmac.c                       | 495 +++++++++++++++++++++
>  5 files changed, 533 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/uniphier-mio-dmac.txt
>  create mode 100644 drivers/dma/uniphier-mdmac.c
>
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada
