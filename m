From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Thu, 14 Apr 2016 17:17:37 +0300
Subject: [PATCH 0/2] [media] atmel-isc: add driver for Atmel ISC
In-Reply-To: <1460533460-32336-1-git-send-email-songjun.wu@atmel.com>
References: <1460533460-32336-1-git-send-email-songjun.wu@atmel.com>
Message-ID: <3857132.BKDS7IHZFq@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Songjun,

On Wednesday 13 Apr 2016 15:44:18 Songjun Wu wrote:
> The Image Sensor Controller driver includes two parts.
> 1) Driver code to implement the ISC function.
> 2) Device tree binding documentation, it describes how
>    to add the ISC in device tree.
> 
> 
> Songjun Wu (2):
>   [media] atmel-isc: add the Image Sensor Controller code
>   [media] atmel-isc: DT binding for Image Sensor Controller driver

I can't see the second patch in the linux-media mailing list archives, could 
you please resend it ?

>  .../devicetree/bindings/media/atmel-isc.txt        |   84 ++
>  drivers/media/platform/Kconfig                     |    1 +
>  drivers/media/platform/Makefile                    |    2 +
>  drivers/media/platform/atmel/Kconfig               |    9 +
>  drivers/media/platform/atmel/Makefile              |    3 +
>  drivers/media/platform/atmel/atmel-isc-regs.h      |  280 ++++
>  drivers/media/platform/atmel/atmel-isc.c           | 1537 ++++++++++++++++
>  7 files changed, 1916 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/atmel-isc.txt
>  create mode 100644 drivers/media/platform/atmel/Kconfig
>  create mode 100644 drivers/media/platform/atmel/Makefile
>  create mode 100644 drivers/media/platform/atmel/atmel-isc-regs.h
>  create mode 100644 drivers/media/platform/atmel/atmel-isc.c

-- 
Regards,

Laurent Pinchart
