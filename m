From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 14 Mar 2017 15:34:24 +0200
Subject: [PATCH v2 4/8] ARM: dts: s3c64xx: Enable watchdog on all S3C64xx
 boards
In-Reply-To: <1633762.1QWnRjdako@amdc3058>
References: <20170311172527.16368-1-krzk@kernel.org>
 <4386279.iJpUOasmTG@amdc3058>
 <CGME20170314133035epcas1p47a04430402688bbb6baebad69b8e5b24@epcas1p4.samsung.com>
 <CAJKOXPeCK1cjY78+PfcTprTnyXJ1k9zcUj8nW7onG8y0TWGzzQ@mail.gmail.com>
 <1633762.1QWnRjdako@amdc3058>
Message-ID: <CAJKOXPemHJ1ww3LkHwP+MKF4Wpp-C2b_Ww4GLkGnjbc9M-wpaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 14, 2017 at 3:30 PM, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
> On Tuesday, March 14, 2017 03:04:28 PM Krzysztof Kozlowski wrote:
>> On Tue, Mar 14, 2017 at 2:58 PM, Bartlomiej Zolnierkiewicz
>> <b.zolnierkie@samsung.com> wrote:
>> >
>> > Hi,
>> >
>> > On Saturday, March 11, 2017 07:25:23 PM Krzysztof Kozlowski wrote:
>> >> Watchdog module does not have external dependencies so it can be safely
>> >> enabled in s3c64xx.dtsi thus making it available for all S3C64xx-based
>> >> boards.
>> >>
>> >> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>> >
>> > Please first fix the driver w.r.t. infinite interrupt in soft mode
>> > issue and only then enable it on more hardware.  IOW this patch
>> > should be placed after patch #7 in the series.
>>
>> The soft-interrupt mode is not the default one so this should not
>> cause any issues by default but I got your point. Makes sense. The
>> pity is the timing. There wasn't much interest in the patchset (no
>> comments since 24 of Feb) so I merged it yesterday evening. Does it
>> brake any platform/board?
>
> OK, let it be as it as it doesn't break the default setup.
>
> However please consider the fact that posting revised patches
> (v2 was posted *yesterday*) for a review and then merging them
> the same day is not a good practice..

v2 was posted on March 11, not yesterday but I got the point that the
rest of world is working from Monday not Sunday. :) And v1 was on 24
of Feb. Usually I try to give them more time but recently there is so
less interest in this that I gave up waiting. I will give them more
time in the future.

Thanks for review!

Krzysztof
