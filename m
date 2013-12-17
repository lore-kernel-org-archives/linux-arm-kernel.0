From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 17 Dec 2013 15:50:40 -0500
Subject: [PATCH 0/4] ARM: keystone: enable GPIO support
In-Reply-To: <1387211981-26045-1-git-send-email-grygorii.strashko@ti.com>
References: <1387211981-26045-1-git-send-email-grygorii.strashko@ti.com>
Message-ID: <52B0B920.1000001@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 16 December 2013 11:39 AM, Grygorii Strashko wrote:
> This series adds Keystone GPIO IP definition in DT and enable GPIO support in
> Keystone configuration file.
> 
> Also, it enables LEDs support for Keystone 2 K2H EVM as specified in board 
> schematic. For more information see:
> - http://www.advantech.com/Support/TI-EVM/EVMK2HX.aspx 
> 
> Depends on:
> [PATCH 0/2] gpio: davinci: reuse for keystone arch
> - https://lkml.org/lkml/2013/12/12/366
> 
> Grygorii Strashko (4):
>   arm: dts: keystone: add GPIO device entry
>   ARM: keystone_defconfig: enable gpio support
>   arm: dts: keystone-evm: add LEDs supports
>   ARM: keystone_defconfig: enable LED support
> 
Patch subjects should be consistent. I will fix
them while applying it on my tree. Will wait
for the GPIO driver support patches state
before applying the subject series.

Thanks for the patches.

Regards,
Santosh
