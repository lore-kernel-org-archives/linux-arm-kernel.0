From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 21 Jul 2011 18:20:29 +0100
Subject: [PATCH] freshen up mm/proc-arm946.S
In-Reply-To: <5A630F46702DD1498FFD48394B4A664CB39A935210@john.ad.clarku.edu>
References: <5A630F46702DD1498FFD48394B4A664CB39A93520F@john.ad.clarku.edu>
	<CA+wbFdeYFQP6GC2zzPW4EPdG82UECT8Fo1FxxHfYq0Rp2tu7qg@mail.gmail.com>
	<5A630F46702DD1498FFD48394B4A664CB39A935210@john.ad.clarku.edu>
Message-ID: <CA+wbFddBtUwff0fmNcDs-fVAahUnG0wotoS61HWSzy7Sgvp_bA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 19, 2011 at 12:54 AM, Brian Julin <BJulin@clarku.edu> wrote:
>
> On Monday, July 18, 2011 6:32 AM, ?Dave Martin [dave.martin at linaro.org] wrote:
>> ?If you've not already done so, I suggest you check that your patch
>> applies against Russell's devel-stable branch. ?There has been a bit
>> of refactoring of some of these files, but I think your patch will
>> stlil apply (unfortunately I'm not in a position to test it right
>> now).
>>
>> The patch looks at least possibly correct (I'm not able to check that
>> either, today...)
>
> Hunk #1 succeeded at 411 (offset -36 lines).
> Hunk #2 succeeded at 420 (offset -36 lines).
>
> Good enough? ?The "linux-next" tree on kernel.org seems to have the patched from
> arm:stable that affect this file, and from the looks of things both hunks are still needed
> and do not conflict with the renovations.

Yes, I think so.  The large offset is caused by replacement of some
code further up the file with macro calls.

I don't see any logical conflict between your patch and those changes.

If you like:

Acked-by: Dave Martin <dave.martin@linaro.org>

> So what now? ?The last time I submitted a patch was over a decade ago... gerg mentioned
> something about "rmk's patch system"?

If you've not already done so, take a look at

http://www.arm.linux.org.uk/developer/patches/info.php
http://www.arm.linux.org.uk/developer/

Cheers
---Dave
