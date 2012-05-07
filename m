From: jgutierrez@ti.com (Gutierrez, Juan)
Date: Mon, 7 May 2012 10:58:06 -0500
Subject: [PATCH v2 2/3] OMAP4: iommu: fix irq and clock name for dsp-iommu
In-Reply-To: <CAK=Wgbb8irgoyt21_tgqg+gFvKxSqs3Ud9KnTUkw-zMuE1X-wQ@mail.gmail.com>
References: <1334360392-1494-1-git-send-email-jgutierrez@ti.com>
 <1334360392-1494-3-git-send-email-jgutierrez@ti.com>
 <CAK=Wgbb8irgoyt21_tgqg+gFvKxSqs3Ud9KnTUkw-zMuE1X-wQ@mail.gmail.com>
Message-ID: <CADVn9REbqna7YHD2bDFyMCEmhfpbzWZ222fuOC2GxWUE705Lbg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ohad

On Sun, May 6, 2012 at 7:33 AM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> Hi Juan,
>
> On Sat, Apr 14, 2012 at 2:39 AM, Juan Gutierrez <jgutierrez@ti.com> wrote:
>> Irq and clock names were wrong for dsp iommu configuration
>> for omap4.
>
> Looks good.
>
>> Renamed tesla_ick to dsp_fck.
>
> If you're resubmitting the series, please indicate here why this
> change is needed (specifically let's mention commit 0e43327 "OMAP4:
> clock: Fix clock names and align with hwmod names").
>
Ok, I will mention the reason of this change in next series.

> Thanks,
> Ohad.



-- 
Thanks

juan gutierrez
