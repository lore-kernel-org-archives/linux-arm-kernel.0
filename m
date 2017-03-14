From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Tue, 14 Mar 2017 14:30:29 +0100
Subject: [PATCH v2 4/8] ARM: dts: s3c64xx: Enable watchdog on all S3C64xx
 boards
In-Reply-To: <CAJKOXPeCK1cjY78+PfcTprTnyXJ1k9zcUj8nW7onG8y0TWGzzQ@mail.gmail.com>
References: <20170311172527.16368-1-krzk@kernel.org>
 <4386279.iJpUOasmTG@amdc3058>
 <CAJKOXPeCK1cjY78+PfcTprTnyXJ1k9zcUj8nW7onG8y0TWGzzQ@mail.gmail.com>
 <CGME20170314133035epcas1p47a04430402688bbb6baebad69b8e5b24@epcas1p4.samsung.com>
Message-ID: <1633762.1QWnRjdako@amdc3058>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, March 14, 2017 03:04:28 PM Krzysztof Kozlowski wrote:
> On Tue, Mar 14, 2017 at 2:58 PM, Bartlomiej Zolnierkiewicz
> <b.zolnierkie@samsung.com> wrote:
> >
> > Hi,
> >
> > On Saturday, March 11, 2017 07:25:23 PM Krzysztof Kozlowski wrote:
> >> Watchdog module does not have external dependencies so it can be safely
> >> enabled in s3c64xx.dtsi thus making it available for all S3C64xx-based
> >> boards.
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> >
> > Please first fix the driver w.r.t. infinite interrupt in soft mode
> > issue and only then enable it on more hardware.  IOW this patch
> > should be placed after patch #7 in the series.
> 
> The soft-interrupt mode is not the default one so this should not
> cause any issues by default but I got your point. Makes sense. The
> pity is the timing. There wasn't much interest in the patchset (no
> comments since 24 of Feb) so I merged it yesterday evening. Does it
> brake any platform/board?

OK, let it be as it as it doesn't break the default setup.

However please consider the fact that posting revised patches
(v2 was posted *yesterday*) for a review and then merging them
the same day is not a good practice..

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
