From: cwchoi00@gmail.com (Chanwoo Choi)
Date: Sat, 21 Jan 2017 14:08:34 +0900
Subject: [PATCH 2/4] clk: samsung: Remove Exynos4415 driver (SoC not
 supported anymore)
In-Reply-To: <c9b51cb6-f798-d41e-afff-f779b963345c@samsung.com>
References: <20170114123642.15581-1-krzk@kernel.org>
 <CGME20170114123727epcas2p296aae6459c8575d7e5def74f18e5c64d@epcas2p2.samsung.com>
 <20170114123642.15581-3-krzk@kernel.org>
 <c9b51cb6-f798-d41e-afff-f779b963345c@samsung.com>
Message-ID: <CAGTfZH2Eh67iMb7bBY2ostNUbxmOtQxy=P7ZRSEDzS4=enyMKg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sylwester,

I add reveiwed-by tag from this patch. But, on you tree, this patch[1] doesn?t
include the my reviewed-by tag.

[1] https://git.linuxtv.org/snawrocki/samsung.git/commit/?h=for-v4.11/clk/next&id=cb4ac949ea14416a2d57b7a343bc4b571074e3bd

2017-01-16 19:32 GMT+09:00 Sylwester Nawrocki <s.nawrocki@samsung.com>:
> On 01/14/2017 01:36 PM, Krzysztof Kozlowski wrote:
>> Support for Exynos4415 is going away because there are no internal nor
>> external users.
>>
>> Since commit 46dcf0ff0de3 ("ARM: dts: exynos: Remove exynos4415.dtsi"),
>> the platform cannot be instantiated so remove also the drivers.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>
> Applied, thanks.
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
