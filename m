From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 18 Jun 2015 15:09:45 +0200
Subject: [PATCH v2 0/2] mfd: flexcom: add a driver for Flexcom
In-Reply-To: <cover.1434632230.git.cyrille.pitchen@atmel.com>
References: <cover.1434632230.git.cyrille.pitchen@atmel.com>
Message-ID: <20150618150945.5cc698be@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 18 Jun 2015 15:05:08 +0200
Cyrille Pitchen <cyrille.pitchen@atmel.com> wrote:

> ChangeLog
> 
> v2:
> - enhance the documentation of DT bindings and change the way the "ranges"
>   property is used.
> - replace __raw_readl() and __raw_writel() by readl() and writel().
> - change the module license to "GPL" for v2 or later
> - print the selected flexcom mode after the hardware version
> 
> v1:
> This series of patches a support to the Atmel Flexcom, a wrapper which
> integrates an USART, a SPI controller and a TWI controller. Only one
> peripheral can be used at a time. The active function is selected though
> the Flexcom Mode Register.

For the whole series,

Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>

> 
> Cyrille Pitchen (2):
>   mfd: devicetree: add bindings for Atmel Flexcom
>   mfd: flexcom: add a driver for Atmel Flexible Serial Communication
>     Unit
> 
>  .../devicetree/bindings/mfd/atmel-flexcom.txt      | 58 +++++++++++++
>  drivers/mfd/Kconfig                                | 11 +++
>  drivers/mfd/Makefile                               |  1 +
>  drivers/mfd/atmel-flexcom.c                        | 97 ++++++++++++++++++++++
>  4 files changed, 167 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/atmel-flexcom.txt
>  create mode 100644 drivers/mfd/atmel-flexcom.c
> 



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
