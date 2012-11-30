From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 30 Nov 2012 12:54:29 +0100
Subject: [PATCH 2/5] mfd: db8500: Update cpufreq device name
In-Reply-To: <20121130105031.GK3176@sortiz-mobl>
References: <1354098464-6665-1-git-send-email-ulf.hansson@stericsson.com>
 <1354098464-6665-3-git-send-email-ulf.hansson@stericsson.com>
 <20121130105031.GK3176@sortiz-mobl>
Message-ID: <CAPDyKFrjd8mtfG2fVOr5CseAK7UEr=W6Ok8FYwP1DsgBtk4RNQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 November 2012 11:50, Samuel Ortiz <sameo@linux.intel.com> wrote:
> Hi Ulf,
>
> On Wed, Nov 28, 2012 at 11:27:41AM +0100, Ulf Hansson wrote:
>> From: Lee Jones <lee.jones@linaro.org>
>>
>> Since the cpufreq driver for ux500 has been renamed from
>> cpufreq-db8500 to cpufreq-dbx500, we need to change the
>> device name here as well.
>>
>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> Cc: Samuel Ortiz <sameo@linux.intel.com>
>> ---
>>  drivers/mfd/db8500-prcmu.c |    4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
> This one doesn't apply to my tree, it would make more sense to push this one
> through Mike's tree.

Yes, you are right! My earlier clock patches which was affecting
cpufreq and mfd was merged through Mikes tree.
I will suggest this complete patchset shall go though Mikes tree.

Do I have your ack for the mfd patch?

> Or I'll queue it to my for-next branch after the next merge window closes, as
> you prefer.
>
> Cheers,
> Samuel.
>
> --
> Intel Open Source Technology Centre
> http://oss.intel.com/
> --
> To unsubscribe from this list: send the line "unsubscribe cpufreq" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Kind regards
Ulf Hansson
