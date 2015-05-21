From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 21 May 2015 11:04:28 +0900
Subject: [PATCH] ARM: dts: Update video-phy node with syscon phandle for
 Exynos3250
In-Reply-To: <CAJKOXPfumy5a6A275ETy7vnztzE20qSuXD_i=ebY9Br47p93Dg@mail.gmail.com>
References: <1426762587-24923-1-git-send-email-b.michalska@samsung.com>
 <CAJKOXPfumy5a6A275ETy7vnztzE20qSuXD_i=ebY9Br47p93Dg@mail.gmail.com>
Message-ID: <CAJKOXPcnYq0pS-akXNDd8TE6wqeq0pg-cx4PK0jeke9z3tHsOw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-05-21 10:57 GMT+09:00 Krzysztof Kozlowski <k.kozlowski@samsung.com>:
> 2015-03-19 19:56 GMT+09:00 Beata Michalska <b.michalska@samsung.com>:
>> As a follow-up to recent changes to Exynos mipi video phy
>> driver, introducing support for PMU regmap in commit
>> e4b3d38088df6f3acd40 ("phy: exynos-video-mipi: Fix regression
>> by adding support for PMU regmap") add a syscon phandle to
>> video-phy node to bring back to life both MIPI DSI displays
>> and MIPI CSIS-2 camera sensors on Exynos3250.
>>
>> Signed-off-by: Beata Michalska <b.michalska@samsung.com>
>
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Tested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>
> Tested on Gear 2 (Exynos3250) board.

Oh, I was too fast. It seems that "reg" property is not needed
anymore. Can you remove it?

Best regards,
Krzysztof
