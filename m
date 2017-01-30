From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 30 Jan 2017 11:39:54 +0100
Subject: [PATCH v2 3/8] pinctrl: samsung: Add support for pad retention
 control for Exynos5433 SoCs
In-Reply-To: <20170127180203.eacwbyb2noqjpmgw@kozik-lap>
References: <1485419634-28331-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170126083402eucas1p187d3d31f62544fc46fae99fc5f74dbfe@eucas1p1.samsung.com>
 <1485419634-28331-4-git-send-email-m.szyprowski@samsung.com>
 <20170126194811.rori5j5hmclniqig@kozik-lap>
 <20170127180203.eacwbyb2noqjpmgw@kozik-lap>
Message-ID: <91de6eca-f70f-d4c9-732e-c48621347ac5@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

On 2017-01-27 19:02, Krzysztof Kozlowski wrote:
> On Thu, Jan 26, 2017 at 09:48:11PM +0200, Krzysztof Kozlowski wrote:
>> On Thu, Jan 26, 2017 at 09:33:49AM +0100, Marek Szyprowski wrote:
>>> This patch adds support for retention control for Exynos5433 SoCs. Three
>>> groups of pins has been defined for retention control: common shared group
>>> for ALIVE, CPIF, eSE, FINGER, IMEM, NFC, PERIC, TOUCH pin banks and
>>> separate control for FSYS and AUD pin banks, for which PMU retention
>>> registers match whole banks.
>>>
>>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>> ---
>>>   drivers/pinctrl/samsung/pinctrl-exynos.c    | 58 +++++++++++++++++++++++++++++
>>>   include/linux/soc/samsung/exynos-regs-pmu.h | 16 ++++++++
> I already have some non-conflicting changes to exynos-regs-pmu.h in my
> branch. Now I want to add some more which will create conflicts.
>
> How about splitting the header to separate patch, so I will take it to
> my exynos-pmu branch?

Okay, I will split this into 2 patches.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
