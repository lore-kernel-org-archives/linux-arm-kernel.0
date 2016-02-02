From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Tue, 2 Feb 2016 16:20:59 +0100
Subject: [PATCH 04/11] arm64: Introduce Allwinner SoC config option
In-Reply-To: <1454348370-3816-5-git-send-email-andre.przywara@arm.com>
References: <1454348370-3816-1-git-send-email-andre.przywara@arm.com>
 <1454348370-3816-5-git-send-email-andre.przywara@arm.com>
Message-ID: <56B0C95B.4040500@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/02/16 18:39, Andre Przywara wrote:
> To prepare for the Allwinner A64 SoC support, introduce a config
> option to allow compiling Allwinner (aka. sunxi) specific drivers
> for the arm64 architecture as well.
> This patch just defines the ARCH_SUNXI symbol to allow Allwinner
> specific drivers to be selected during kernel configuration.
> Since the MMC driver is quite essential for Linux to be useful, select
> it by default.
>

This mostly depends on the board you have. The rootfs could be on the 
flash, on nfs or even on a usb stick.

I don't see why MMC support should be essential for A64 SoC.

Regards,
Matthias
