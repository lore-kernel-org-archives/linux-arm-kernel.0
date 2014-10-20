From: ta.omasab@gmail.com (Thomas Abraham)
Date: Mon, 20 Oct 2014 17:08:35 +0530
Subject: [PATCH v11 5/6] cpufreq: exynos: remove exynos4210/5250 specific
 cpufreq driver support
In-Reply-To: <CAKohpo=0wQD4mWq+GbpMnLR6W5u9U7n16KUyecffL6BAxeYVOQ@mail.gmail.com>
References: <1413805281-6269-1-git-send-email-thomas.ab@samsung.com>
 <1413805281-6269-2-git-send-email-thomas.ab@samsung.com>
 <1413805281-6269-3-git-send-email-thomas.ab@samsung.com>
 <1413805281-6269-4-git-send-email-thomas.ab@samsung.com>
 <1413805281-6269-5-git-send-email-thomas.ab@samsung.com>
 <1413805281-6269-6-git-send-email-thomas.ab@samsung.com>
 <CAKohpo=0wQD4mWq+GbpMnLR6W5u9U7n16KUyecffL6BAxeYVOQ@mail.gmail.com>
Message-ID: <CAJuA9ai+5UBHs60CVtf=QOgqGk-EnPZhP237TJwmt76MiJMsyg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 20, 2014 at 5:02 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 20 October 2014 17:11, Thomas Abraham <thomas.ab@samsung.com> wrote:
>> Exynos4210 and Exynos5250 based platforms have switched over to use generic
>> cpufreq drivers for cpufreq functionality. So the Exynos specific cpufreq
>> drivers for these platforms can be removed.
>>
>> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>> Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>> Tested-by: Chander Kashyap <k.chander@samsung.com>
>> ---
>>  drivers/cpufreq/Kconfig.arm |   22 ----------------------
>>  drivers/cpufreq/Makefile    |    2 --
>>  2 files changed, 0 insertions(+), 24 deletions(-)
>
> Looks like you forgot removing drivers ;)

Sorry, missed it while doing the rebase. I will fix and send an updated patch.

Thanks,
Thomas.

> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
