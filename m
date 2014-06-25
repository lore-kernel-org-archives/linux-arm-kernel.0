From: afaerber@suse.de (=?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?=)
Date: Wed, 25 Jun 2014 13:54:02 +0200
Subject: [PATCH v2 Resend 1/2] ARM: EXYNOS: Update secondary boot addr
 for secure mode
In-Reply-To: <03f301cf906a$ab25d470$01717d50$@samsung.com>
References: <1401250382-24046-1-git-send-email-sachin.kamat@linaro.org>
 <5388CBB9.1050003@suse.de>
 <CAK5sBcETe20PWRV+z5Gb=hQNk13wE0PbmcvEmC9TM6nD2mi=ew@mail.gmail.com>
 <03f301cf906a$ab25d470$01717d50$@samsung.com>
Message-ID: <53AAB85A.7060804@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 25.06.2014 13:43, schrieb Kukjin Kim:
> Sachin Kamat wrote:
>>
>> On Fri, May 30, 2014 at 11:49 PM, Andreas F?rber <afaerber@suse.de> wrote:
>>> Am 28.05.2014 06:13, schrieb Sachin Kamat:
>>>> Almost all Exynos-series of SoCs that run in secure mode don't need
>>>> additional offset for every CPU, with Exynos4412 being the only
>>>> exception.
>>>>
>>>> Tested on Origen-Quad (Exynos4412) and Arndale-Octa (Exynos5420).
>>>>
>>>> While at it, fix the coding style (space around *).
>>>>
>>>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>>>> Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
>>>> ---
>>>>  arch/arm/mach-exynos/firmware.c |    9 +++++++--
>>>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>>
>>> Fixes ODROID-XU (Exynos5410) as well - thought it had been a prereq to
>>> applying the 5410 patches...
>>>
>>> Tested-by: Andreas F?rber <afaerber@suse.de>

FWIW meanwhile I also successfully tested it on 5420 based Arndale Octa.

I can also check on 5250 based Spring, now that it's working, if that
helps build confidence in the patch.

Cheers,
Andreas

>> Kukjin, this patch is required to bring up 4 A15 cores on some 5410
>> and 5420 based
>> boards. Can you please queue this up for the upcoming rc as fixes?
> 
> Sure, I will take this into fixes.
> 
> Thanks,
> Kukjin

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg
