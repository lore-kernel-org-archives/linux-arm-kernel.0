From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 25 Apr 2018 14:55:03 +0200
Subject: [RFC 08/10] spi: s3c64xx: samsung: Remove support for Exynos5440
In-Reply-To: <066e917b-7207-9c10-4d6c-07273c6f49d9@samsung.com>
References: <20180424203239.21885-1-krzk@kernel.org>
 <CGME20180424203409epcas2p45f55e5a5d211e78d4cadc3c4ffa5a9c0@epcas2p4.samsung.com>
 <20180424203239.21885-9-krzk@kernel.org>
 <066e917b-7207-9c10-4d6c-07273c6f49d9@samsung.com>
Message-ID: <CAJKOXPcOCSKbRMEn738MwvS6f2DhxNPDb0BcNn0FY2Jqx1MtbQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 25, 2018 at 2:49 PM, Sylwester Nawrocki
<s.nawrocki@samsung.com> wrote:
> On 04/24/2018 10:32 PM, Krzysztof Kozlowski wrote:
>> The Exynos5440 is not actively developed, there are no development
>> boards available and probably there are no real products with it.
>> Remove wide-tree support for Exynos5440.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>
> It's good you didn't remove S3C64XX_SPI_QUIRK_POLL entirely as it will
> be needed for Exynos5433 ISP SPI controllers.

Ah, actually I did not plan to skip it... I just missed it :).
I should check affected drivers if this removal left any unused
symbols (except the one mentioned).

Thanks for hint!

Krzysztof
