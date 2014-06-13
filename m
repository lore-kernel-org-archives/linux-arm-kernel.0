From: spk.linux@gmail.com (Sachin Kamat)
Date: Fri, 13 Jun 2014 21:55:36 +0530
Subject: [PATCH v2 Resend 1/2] ARM: EXYNOS: Update secondary boot addr for
 secure mode
In-Reply-To: <5388D129.6000706@samsung.com>
References: <1401250382-24046-1-git-send-email-sachin.kamat@linaro.org>
 <5388CBB9.1050003@suse.de> <5388D129.6000706@samsung.com>
Message-ID: <CAK5sBcE9XoRKWoQbas1CcvuYNAnfnXUGBO-CA=TdQTkF61OjOQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kukjin,

On Sat, May 31, 2014 at 12:12 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> On 05/31/14 03:19, Andreas F?rber wrote:
>>
>> Am 28.05.2014 06:13, schrieb Sachin Kamat:
>>>
>>> Almost all Exynos-series of SoCs that run in secure mode don't need
>>> additional offset for every CPU, with Exynos4412 being the only
>>> exception.
>>>
>>> Tested on Origen-Quad (Exynos4412) and Arndale-Octa (Exynos5420).
>>>
>>> While at it, fix the coding style (space around *).
>>>
>>> Signed-off-by: Sachin Kamat<sachin.kamat@linaro.org>
>>> Signed-off-by: Tushar Behera<tushar.behera@linaro.org>
>>> ---
>>>   arch/arm/mach-exynos/firmware.c |    9 +++++++--
>>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>>
>> Fixes ODROID-XU (Exynos5410) as well - thought it had been a prereq to
>> applying the 5410 patches...
>>
>> Tested-by: Andreas F?rber<afaerber@suse.de>
>>
> Andreas, thanks for your test :-)
>
> Sachin, How about exynos4210, 5250, 5260 and 5440?...
> I need to check again, honestly I don't remember all of Exynos SoCs'
> different things ;-) Then will apply into fixes for 3.16.

ping..

 --
Regards,
Sachin.
