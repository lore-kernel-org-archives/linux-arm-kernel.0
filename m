From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Thu, 25 Sep 2014 11:58:14 +0200
Subject: [PATCH 0/5] pinctrl: samsung: Data structure clean-up
In-Reply-To: <542271E8.4020606@samsung.com>
References: <1411499141-26551-1-git-send-email-tomasz.figa@gmail.com>
 <542271E8.4020606@samsung.com>
Message-ID: <CABxcv=nWddbECGxBEZCa1K3KDeR5uhNWaEzFsuTfNxC1xq2gFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Tomasz,

On Wed, Sep 24, 2014 at 9:25 AM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>>
>> This series should not introduce any functional changes.
>>
>> Tested on S3C6410-based Mini6410 board, booting with device tree.
>>
>> Marek, Bart, could you do some testing on Exynos-based boards,
>> just to make sure?
>
>
> Works fine on Exynos4412 based OdroidU3+ and Exynos4210 Universal C210.
>
> For the whole patchset:
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
>

I tested this series on an Exynos5250 Snow and an Exynos5420 Peach Pit
Chromebook and both were working fine.

Tested by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Best regards,
Javier
