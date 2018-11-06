From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 6 Nov 2018 22:19:15 +0900
Subject: [PATCH v4 0/2] dmaengine: add UniPhier MIO DMAC driver
In-Reply-To: <1539276063-5103-1-git-send-email-yamada.masahiro@socionext.com>
References: <1539276063-5103-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CAK7LNASsbpC53aiQGRdQaukFOLX_ZN09ZOPU1CqF_bsR2u01hQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 12, 2018 at 1:42 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> 1/2: DT-binding
> 2/2: driver
>


Gentle ping...



> Masahiro Yamada (2):
>   dt-bindings: dmaengine: add DT binding for UniPhier MIO DMAC
>   dmaengine: uniphier-mdmac: add UniPhier MIO DMAC driver
>
>  .../devicetree/bindings/dma/uniphier-mio-dmac.txt  |  25 +
>  MAINTAINERS                                        |   1 +
>  drivers/dma/Kconfig                                |  11 +
>  drivers/dma/Makefile                               |   1 +
>  drivers/dma/uniphier-mdmac.c                       | 506 +++++++++++++++++++++
>  5 files changed, 544 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/uniphier-mio-dmac.txt
>  create mode 100644 drivers/dma/uniphier-mdmac.c
>
> --
> 2.7.4
>


--
Best Regards
Masahiro Yamada
