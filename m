From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 27 Nov 2017 14:17:04 -0200
Subject: [PATCH v3] ARM: dts: imx6qdl-nitrogen6x: Add SPI NOR partitions
In-Reply-To: <20171127133127.16985-1-otavio@ossystems.com.br>
References: <20171127133127.16985-1-otavio@ossystems.com.br>
Message-ID: <CAOMZO5Dtf6mjWt1wg_5NDUNAe4XZ3jvxu0KC2CaUo0wE7gjaRQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 27, 2017 at 11:31 AM, Otavio Salvador
<otavio@ossystems.com.br> wrote:
> This adds the partitions definition for the SPI NOR to provide
> backward compatibility with the documented[1] layout used with
> Boundary Devices BSP.
>
> 1. https://boundarydevices.com/boot-flash-access-linux/
>
> It exports to Linux:
>
>  mtd0: bootloader
>  mtd1: env
>  mtd2: splash
>
> Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>

Has this been tested? I mean, have you tested the locking mechanism is
really working in this SPI NOR flash?

As far as I can see the SPI locking mechanism does not need device
tree properties.
