From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 29 Nov 2017 22:48:33 +0800
Subject: [PATCH v4] ARM: dts: imx6qdl-nitrogen6x: Add SPI NOR partitions
In-Reply-To: <20171128174924.5149-1-otavio@ossystems.com.br>
References: <20171128174924.5149-1-otavio@ossystems.com.br>
Message-ID: <20171129144832.GQ9376@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 28, 2017 at 03:49:24PM -0200, Otavio Salvador wrote:
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

Applied, thanks.
