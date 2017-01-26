From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 26 Jan 2017 16:32:33 +0200
Subject: [PATCH v2 0/8] Pad retentions support for Exynos5433
In-Reply-To: <CACRpkdawiAp3xqVd7J5ZAd2dQ=X09DGybyw0EVp=07w8-ccKfA@mail.gmail.com>
References: <CGME20170126083401eucas1p20b4794fe46ccf2189bf734f0d8e3c536@eucas1p2.samsung.com>
 <1485419634-28331-1-git-send-email-m.szyprowski@samsung.com>
 <CACRpkdawiAp3xqVd7J5ZAd2dQ=X09DGybyw0EVp=07w8-ccKfA@mail.gmail.com>
Message-ID: <CAJKOXPd+WYyB4KbX2XN_Y615KR8AMZW8A+uV+6vU_AN3u+QCaA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 26, 2017 at 11:50 AM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> On Thu, Jan 26, 2017 at 9:33 AM, Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
>
>> Patches in this patchset depends on each other. They are order in such a
>> way to make the changes bisectable.
>>
>> Patch #3 has runtime dependency on #1.
>> Patch #5 has runtime dependency on #3.
>> Patch #6 has runtime dependency on #4.
>>
>> This patchset also directly depends on the "Move pad retention control to
>> Exynos pin controller driver" patchset:
>> https://www.spinics.net/lists/arm-kernel/msg556074.html
>
> Do we *have* to merge it runtime-bisectably?
>
> I'm asking because we need a huge immutable branch
> (I guess in the MFD subsystem) to deal with that.

It helps a lot with finding introduced issues, so I think yes - we
want it runtime-bisectable. The board has already support in mainline
so it is not theoretical runtime...

Best regards,
Krzysztof
