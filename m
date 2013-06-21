From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Jun 2013 09:31:58 +0200
Subject: [PATCH V10 0/4] PCIe support for Samsung Exynos5440 SoC
In-Reply-To: <003901ce6e50$03d039a0$0b70ace0$@samsung.com>
References: <003901ce6e50$03d039a0$0b70ace0$@samsung.com>
Message-ID: <201306210931.58428.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 21 June 2013, Jingoo Han wrote:
> Changes between v9 and v10:
>   * Changed the file name from 'pci-designware.c' to 'pcie-designware.c'
>     guided by Pratyush Anand, because synopsis pcie and pci controllers
>     are different.
>   * Fixed the typos of document, reported by Sachin Kamat.
> 
> Changes between v8 and v9:
>   * Changed the file name from 'exynos-pcie.txt' to 'designware-pcie.txt'.
>   * Added 'snps,dw-pcie' string to compatible property.
> 
> Changes between v7 and v8:
>   * Changed the file name from 'pci-exynos.c' to 'pci-designware.c',
>     and added a generic string for compatible property to exynos-pcie.txt
>   * Moved pci_add_resource_offset() for I/O space to the 'if' clause
>   * Added Arnd's Acked-by
> 
> Changes between v6 and v7:
>   * Split ARM DT patch to two patches
>   * Fixed node naming
>   * Added Arnd's Acked-by

Ok, that takes care of all my comments.

Bjorn, are you still considering to merge this for 3.11 or have you
closed your tree for the merge window? I think it would be good to get
it in.

	Arnd
