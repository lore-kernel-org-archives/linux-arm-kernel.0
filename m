From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 12 Dec 2017 11:09:00 +0100
Subject: [PATCH v2] ARM: dts: exynos: Enable Mixer node for Exynos5800
 Peach Pi machine
In-Reply-To: <CAJKOXPc1rJCWABXUuyU2MKxnLY-MptrM9Mm0HyHVCJn870R+sg@mail.gmail.com>
References: <20171212074208.30753-1-javierm@redhat.com>
 <CAJKOXPc1rJCWABXUuyU2MKxnLY-MptrM9Mm0HyHVCJn870R+sg@mail.gmail.com>
Message-ID: <CAJKOXPc1_n2cdgjuFbA9jNdcSXxfr8Zjf=fUx_jt_N3+LP0n8A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 12, 2017 at 10:55 AM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Tue, Dec 12, 2017 at 8:42 AM, Javier Martinez Canillas
> <javierm@redhat.com> wrote:
>> Commit 1cb686c08d12 ("ARM: dts: exynos: Add status property to Exynos 542x
>> Mixer nodes") disabled the Mixer node by default in the DTSI and enabled
>> for each Exynos 542x DTS. But unfortunately it missed to enable it for the
>> Exynos5800 Peach Pi machine, since the 5800 is also an 542x SoC variant.
>>
>> Fixes: 1cb686c08d12 ("ARM: dts: exynos: Add status property to Exynos 542x Mixer nodes")
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>> Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>
>> ---
>>
>> Changes in v2:
>> - Remove RFT tag.
>
> Thanks guys! However I still would like to see a tested-by for this on
> Peach Pi (AFAIU, Marek's only acked the code/solution).

On the other hand I could just apply it for my for-next branch and
we'll see if it fixes kernel-ci boot tests... Not a nice way of
testing but apparently no one has Peach Pi.

Best regards,
Krzysztof
