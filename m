From: sachin.kamat@samsung.com (Sachin Kamat)
Date: Sat, 5 Jul 2014 20:23:25 +0530
Subject: [PATCH v2 Resend 1/2] ARM: EXYNOS: Update secondary boot addr for
 secure mode
In-Reply-To: <03f301cf906a$ab25d470$01717d50$@samsung.com>
References: <1401250382-24046-1-git-send-email-sachin.kamat@linaro.org>
 <5388CBB9.1050003@suse.de>
 <CAK5sBcETe20PWRV+z5Gb=hQNk13wE0PbmcvEmC9TM6nD2mi=ew@mail.gmail.com>
 <03f301cf906a$ab25d470$01717d50$@samsung.com>
Message-ID: <CAK5sBcFfd0oe_87j7NcskK9opGQYA0uYA5WyqfHMnp-O0xCJqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 25, 2014 at 5:13 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Sachin Kamat wrote:
>>
>> On Fri, May 30, 2014 at 11:49 PM, Andreas F?rber <afaerber@suse.de> wrote:
>> > Am 28.05.2014 06:13, schrieb Sachin Kamat:
>> >> Almost all Exynos-series of SoCs that run in secure mode don't need
>> >> additional offset for every CPU, with Exynos4412 being the only
>> >> exception.
>> >>
>> >> Tested on Origen-Quad (Exynos4412) and Arndale-Octa (Exynos5420).
>> >>
>> >> While at it, fix the coding style (space around *).
>> >>
>> >> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>> >> Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
>> >> ---
>> >>  arch/arm/mach-exynos/firmware.c |    9 +++++++--
>> >>  1 file changed, 7 insertions(+), 2 deletions(-)
>> >
>> > Fixes ODROID-XU (Exynos5410) as well - thought it had been a prereq to
>> > applying the 5410 patches...
>> >
>> > Tested-by: Andreas F?rber <afaerber@suse.de>
>> >
>>
>> Kukjin, this patch is required to bring up 4 A15 cores on some 5410
>> and 5420 based
>> boards. Can you please queue this up for the upcoming rc as fixes?
>
> Sure, I will take this into fixes.

Kukjin,

I don't see this patch in your fixes-2 branch yet.


>
> Thanks,
> Kukjin
>

Regards,
Sachin.
