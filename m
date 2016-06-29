From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 29 Jun 2016 17:29:35 +0200
Subject: [PATCH 6/6] nuc900: add nuc970 platform defconfig file
In-Reply-To: <1466851042-22239-7-git-send-email-vw@iommu.org>
References: <1466851042-22239-1-git-send-email-vw@iommu.org>
 <1466851042-22239-7-git-send-email-vw@iommu.org>
Message-ID: <295628831.A66JCuDHTk@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday, June 25, 2016 6:37:22 PM CEST Wan Zongshun wrote:
> Add nuc970_defconfig file support.
> 
> Signed-off-by: Wan Zongshun <mcuos.com@gmail.com>
> ---
>  arch/arm/configs/nuc970_defconfig | 1278 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 1278 insertions(+)
>  create mode 100644 arch/arm/configs/nuc970_defconfig
> 
> 

Please run 'make savedefconfig' to create a smaller file, then review every
line to see if it actually makes sense for you.

	Arnd
