From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Thu, 10 May 2012 08:20:00 +0300
Subject: [PATCH v3 2/2] omap4: iommu: fix irq and clock name for dsp-iommu
In-Reply-To: <1336616370-28268-3-git-send-email-jgutierrez@ti.com>
References: <1336616370-28268-1-git-send-email-jgutierrez@ti.com>
 <1336616370-28268-3-git-send-email-jgutierrez@ti.com>
Message-ID: <CAK=WgbZsM6HvFKTsnjK_LD=6wi75i2Ec_H2LvF782K5iZbT5xQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 10, 2012 at 5:19 AM, Juan Gutierrez <jgutierrez@ti.com> wrote:
> Irq and clock names were wrong for dsp iommu configuration
> for omap4.
>
> - Renamed tesla_ick to dsp_fck:
> ? This is required because the new naming convention introduced
> ? by: commit 0e43327 "OMAP4 clock: Fix clock names and align
> ? with hwmod names"
>
> - Renamed INT_44XX_DSP_MMU to OMAP44XX_IRQ_TESLA_MMU.
> ? Naming convention adopted since: commit e927f8d "omap4: Add
> ? auto-generated irq and dma headers"
>
> - dsp-iommu is enabled by default.
>
> Signed-off-by: Juan Gutierrez <jgutierrez@ti.com>

Acked-by: Ohad Ben-Cohen <ohad@wizery.com>
