From: olof@lixom.net (Olof Johansson)
Date: Mon, 16 Jul 2012 19:19:43 -0700
Subject: [PATCH] ARM: exynos: enable more platforms in defconfig
In-Reply-To: <145c01cd63be$f6645900$e32d0b00$%kim@samsung.com>
References: <1338784735-10683-1-git-send-email-olof@lixom.net>
 <145c01cd63be$f6645900$e32d0b00$%kim@samsung.com>
Message-ID: <CAOesGMicSKkDyg64mBMjbagFq-dp=B0DHgv1kpiEThT40LAA-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 16, 2012 at 6:53 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Kukjin Kim wrote:
>>
>> Olof Johansson wrote:
>> >
>> Hi Olof,
>>
>> Sorry for late reply on this, I came back from travelling, anyway.
>>
>> > This enables the new EXYNOS5 platforms in the defconfig, and enables DT
>> > support on EXYNOS4.
>> >
>> Yes, agree, it's time to move on new defconfig for supporting DT.
>>
>> > While I'm at it, I renamed it exynos4_defconfig -> exynos_defconfig,
>> > since it now encompasses all (known and supported) versions of exynos.
>> >
>> OK, basically looks good to me. But how about keeping exynos4_defconfig
>> for non-DT and creating exynos_defconfig for supporting DT on EXYNOS4 and
>> EXYNOS5? Of course, we can remove exynos4_defconfig after finishing of
>> EXYNOS DT later.
>>
> Olof, how about following?

I think I would prefer a superset single config instead, that enables
both DT and non-DT platforms. All drivers should compile just fine for
either probe method in the same binary.

But, I guess one of each is ok and better than nothing.


-Olof
