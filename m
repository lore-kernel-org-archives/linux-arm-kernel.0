From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Wed, 18 Jan 2017 01:27:14 -0300
Subject: [PATCH v2 1/2] arm64: dts: exynos: Add USB 3.0 controller node
 for Exynos7
In-Reply-To: <9f45a921-ebfb-c252-20bb-3a7adf508343@samsung.com>
References: <1484665444-23365-1-git-send-email-pankaj.dubey@samsung.com>
 <CGME20170117150121epcas1p102bd1355f780a56e14a0a7a81bd6dfaf@epcas1p1.samsung.com>
 <1484665444-23365-2-git-send-email-pankaj.dubey@samsung.com>
 <20170117182318.fvatrazvyuzmdsor@kozik-lap>
 <9f45a921-ebfb-c252-20bb-3a7adf508343@samsung.com>
Message-ID: <CABxcv=kFe+En+6f-xKJS5nnJLsdXViAd7KWJmJYEhvZG5DU+_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Pankaj,

On Wed, Jan 18, 2017 at 12:16 AM, pankaj.dubey <pankaj.dubey@samsung.com> wrote:
> On Tuesday 17 January 2017 11:53 PM, Krzysztof Kozlowski wrote:

[snip]

>>> +
>>> +                    dwc3 {
>>
>> dtc should complain here - you need:
>>       dwc3 at 15400000
>
> No, it didn't complain. Anyway, I will update as it's already taken care
> in other Exynos SoC DTSi files.
>

It only complains if you run dtc with warnings enabled, i.e: make W=1
exynos7-espresso.dtb

Best regards,
Javier
