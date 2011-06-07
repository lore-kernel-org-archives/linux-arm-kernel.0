From: tushar.behera@linaro.org (Tushar Behera)
Date: Tue, 7 Jun 2011 21:12:35 +0530
Subject: [PATCH] ARM:SAMSUNG: Move S3C DMA driver to drivers/dma
In-Reply-To: <1307432901-22781-1-git-send-email-alim.akhtar@samsung.com>
References: <1307432901-22781-1-git-send-email-alim.akhtar@samsung.com>
Message-ID: <BANLkTinp_z7OiBPnYvD7NjDYmvfrEV7i+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alim,

On 7 June 2011 13:18, root <alim.akhtar@samsung.com> wrote:
> Signed-off-by: alim.akhtar <alim.akhtar@samsung.com>
> ---
> ?arch/arm/configs/exynos4_defconfig | ? ?1 +
> ?arch/arm/configs/s5p64x0_defconfig | ? ?1 +
> ?arch/arm/configs/s5pc100_defconfig | ? ?1 +
> ?arch/arm/configs/s5pv210_defconfig | ? ?1 +
> ?arch/arm/plat-samsung/Kconfig ? ? ?| ? ?6 -
> ?arch/arm/plat-samsung/Makefile ? ? | ? ?2 -
> ?arch/arm/plat-samsung/s3c-pl330.c ?| 1244 ------------------------------------
> ?drivers/dma/Kconfig ? ? ? ? ? ? ? ?| ? ?8 +
> ?drivers/dma/Makefile ? ? ? ? ? ? ? | ? ?2 +
> ?drivers/dma/s3c-pl330.c ? ? ? ? ? ?| 1244 ++++++++++++++++++++++++++++++++++++
> ?10 files changed, 1258 insertions(+), 1252 deletions(-)
> ?delete mode 100644 arch/arm/plat-samsung/s3c-pl330.c
> ?create mode 100644 drivers/dma/s3c-pl330.c
>
If the patch involves file movement or file renaming, then use -M flag
while creating the patch. This would indicate the file movement and
would essentially make the patch smaller.


-- 
Tushar Behera
