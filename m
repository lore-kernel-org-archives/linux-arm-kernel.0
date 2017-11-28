From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 28 Nov 2017 16:14:23 -0200
Subject: [PATCH v4] ARM: dts: imx6qdl-nitrogen6x: Add SPI NOR partitions
In-Reply-To: <20171128174924.5149-1-otavio@ossystems.com.br>
References: <20171128174924.5149-1-otavio@ossystems.com.br>
Message-ID: <CAOMZO5CHYXpL-J3tTo_gNwmth7h_2aY-JJnia7tx6gbH==ff_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 28, 2017 at 3:49 PM, Otavio Salvador
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

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
