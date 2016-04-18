From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 18 Apr 2016 17:05:26 +0200
Subject: [PATCH 0/2] ARM: lpc32xx: updates to lpc32xx_defconfig
In-Reply-To: <1460950283-25053-1-git-send-email-vz@mleia.com>
References: <1460950283-25053-1-git-send-email-vz@mleia.com>
Message-ID: <5278209.vnV5mGJPF7@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 18 April 2016 06:31:21 Vladimir Zapolskiy wrote:
> The changeset updates lpc32xx_defconfig to match savedefconfig
> and adds ARM PrimeCell PL175 memory controller driver to a build.
> 
> Vladimir Zapolskiy (2):
>   ARM: LPC32xx: defconfig update
>   ARM: LPC32xx: add PL175 memory controller driver to defconfig
> 
>  arch/arm/configs/lpc32xx_defconfig | 29 +++++++++++------------------
>  1 file changed, 11 insertions(+), 18 deletions(-)

Looks all good to me. As a reminder: if you want the patches to be
picked up (rather than reviewed), please send them to arm at kernel.org.

	Arnd
