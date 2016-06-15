From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 15 Jun 2016 11:10:29 +0200
Subject: arm-soc boot: 619 boots: 11 failed, 605 passed with 2 offline,
 1 conflict (v4.7-rc3-216-gec0776a212c1)
In-Reply-To: <5760acd0.571a1c0a.34a58.7333@mx.google.com>
References: <5760acd0.571a1c0a.34a58.7333@mx.google.com>
Message-ID: <9297488.MELcTREXgu@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, June 14, 2016 6:18:08 PM CEST kernelci. org bot wrote:
> arm:
> 
>     multi_v7_defconfig+CONFIG_PROVE_LOCKING=y:
>         exynos5410-odroidxu: 1 failed lab
> 
>     multi_v7_defconfig+CONFIG_LKDTM=y:
>         exynos5410-odroidxu: 1 failed lab
> 
>     multi_v7_defconfig+CONFIG_THUMB2_KERNEL=y+CONFIG_ARM_MODULE_PLTS=y:
>         exynos5410-odroidxu: 1 failed lab
> 
>     multi_v7_defconfig+CONFIG_EFI=y:
>         exynos5410-odroidxu: 1 failed lab
> 
>     exynos_defconfig:
>         exynos5410-odroidxu: 1 failed lab
> 
>     multi_v7_defconfig+CONFIG_ARM_LPAE=y:
>         exynos5410-odroidxu: 1 failed lab
> 
>     multi_v7_defconfig:
>         exynos5410-odroidxu: 1 failed lab
> 
>     multi_v5_defconfig:
>         at91sam9261ek: 1 failed lab
>         at91sam9m10g45ek: 1 failed lab
>         at91sam9x25ek: 1 failed lab
>         at91sam9x35ek: 1 failed lab

These all seem to have broken after yesterday's merges, adding
Alexandre and Krzysztof to Cc here so they can have a look.

	Arnd
