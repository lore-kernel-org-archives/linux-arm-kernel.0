From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 14 Mar 2017 16:56:44 +0200
Subject: [PATCH v2 2/4] phy: exynos5: Remove duplicated defines of PHY
 register defines
In-Reply-To: <10362020.XmlhBa7gD6@amdc3058>
References: <20170311182534.13345-1-krzk@kernel.org>
 <CGME20170314143705epcas5p42e226d072b9ec705bb0dca981923f313@epcas5p4.samsung.com>
 <20170311182534.13345-3-krzk@kernel.org> <10362020.XmlhBa7gD6@amdc3058>
Message-ID: <CAJKOXPcZ4nks2k9M91fr7QX25Zuk-OTUGuvG7xRepE8ZPWSGyg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 14, 2017 at 4:37 PM, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
> On Saturday, March 11, 2017 08:25:32 PM Krzysztof Kozlowski wrote:
>> Phy drivers access PMU region through regmap provided by exynos-pmu
>> driver.   However there is no need to duplicate defines for PMU
>> registers.  Instead just use whatever is defined in exynos-regs-pmu.h.
>>
>> This reduces number of defines and allows removal of one header.
>
> exynos5-pmu.h goes away in patch #4

Right, I will leave only the first part about number of defines.

Thanks,
Krzysztof
