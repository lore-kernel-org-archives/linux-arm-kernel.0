From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 12 Dec 2011 09:56:10 +0900
Subject: PL330: Merge PL330 drivers
In-Reply-To: <1323306645-4003-1-git-send-email-boojin.kim@samsung.com>
References: <1323306645-4003-1-git-send-email-boojin.kim@samsung.com>
Message-ID: <000601ccb868$d711f690$8535e3b0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Boojin Kim wrote:
> 
> In-Reply-To:
> 
> PL330 driver is divided into 2 parts.
> First is the PL330 API driver that located on driver/dma/.
> Second is the low-level PL330 driver that is located on arch/arm/common/.
> But, It's not needed anymore to divided PL330 driver into 2 parts
> Low-level PL330 driver is only used for PL330 API driver on driver/dma
> because samsung specific S3C-PL330 driver was gone.
> So, This patch merges 'arch/arm/common/pl330' into 'driver/dma/pl330.c'.
> 
> [PATCH 1/2] DMA: PL330: Merge PL330 drivers
> [PATCH 2/2] DMA: PL330: Remove an unused function

Hi all,

Since Boojin's git send-email has problem, this series re-submitted on
Sunday like following :(
Please kindly ignore this series.

[PATCH 1/3] ARM: EXYNOS: Support DMA driver for Exynos4x12 series
[PATCH 2/3] DMA: PL330: Merge PL330 drivers
[PATCH 3/3] DMA: PL330: Remove an unused function

Sorry for bothering.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
