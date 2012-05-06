From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Sun, 6 May 2012 15:33:41 +0300
Subject: [PATCH v2 2/3] OMAP4: iommu: fix irq and clock name for dsp-iommu
In-Reply-To: <1334360392-1494-3-git-send-email-jgutierrez@ti.com>
References: <1334360392-1494-1-git-send-email-jgutierrez@ti.com>
 <1334360392-1494-3-git-send-email-jgutierrez@ti.com>
Message-ID: <CAK=Wgbb8irgoyt21_tgqg+gFvKxSqs3Ud9KnTUkw-zMuE1X-wQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Juan,

On Sat, Apr 14, 2012 at 2:39 AM, Juan Gutierrez <jgutierrez@ti.com> wrote:
> Irq and clock names were wrong for dsp iommu configuration
> for omap4.

Looks good.

> Renamed tesla_ick to dsp_fck.

If you're resubmitting the series, please indicate here why this
change is needed (specifically let's mention commit 0e43327 "OMAP4:
clock: Fix clock names and align with hwmod names").

Thanks,
Ohad.
