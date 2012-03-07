From: kmpark@infradead.org (Kyungmin Park)
Date: Wed, 7 Mar 2012 23:20:34 +0900
Subject: [PATCH v2 04/11] ARM: EXYNOS: add interrupt definitions for
 EXYNOS5250
In-Reply-To: <4F575EC8.2090205@samsung.com>
References: <1328981685-8602-1-git-send-email-kgene.kim@samsung.com>
 <1328981685-8602-5-git-send-email-kgene.kim@samsung.com>
 <CAOesGMhmcnt6LPb9O+3420VgG=PiCnOjzZA3JqsA=4OdHN-R-g@mail.gmail.com>
 <00a901ccf084$90460900$b0d21b00$%kim@samsung.com>
 <CAOesGMgedngJKRVCYwK=+xRnchXj4StGLTVqvv9BMqVhtM=5RA@mail.gmail.com>
 <4F575EC8.2090205@samsung.com>
Message-ID: <CAH9JG2VhCT6psHa3nhMCeA6dF12r1EuAaXMHxca44dOV1T5nbg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 7, 2012 at 10:12 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> On 03/06/12 10:55, Olof Johansson wrote:
>>
>> Hi,
>>
>> On Tue, Feb 21, 2012 at 2:35 AM, Kukjin Kim<kgene.kim@samsung.com> ?wrote:
>>
>>> Yes, as you said, it brakes single zImage for EXYNOS4 + EXYNOS5
>>> (mach-exynos). So I'm working on regarding resource for EXYNOS SoCs and I
>>> think, it can resolve the problem you said before v3.4 merge window.
>>>
>>> If any updates, let you know.
>>
>>
>> Just a friendly reminder; the time is close to running out for staging
>> new code for 3.4.
>>
> Hi Olof,
>
> Thanks for your kindly reminder but I couldn't finish it yet because it is
> required to touch most of samsung stuff, and it's a big change. Frankly, I
> need more time...
>
> So how about sending current exynos5 stuff for now and then sorting out
> single kernel for exynos4 and exynos5 next time? Actually, this exynos5 arch
> part is _really_ needed for developing/contribution of drivers on exynos5.
No,

I heard too many times. "we have plan to support ..." but I didn't see
any progress.
it's general rules. you should fix it correctly and merged correctly
instead of "not now"

Thank you,
Kyungmin Park
>
>
> Thanks.
>
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc"
> in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
