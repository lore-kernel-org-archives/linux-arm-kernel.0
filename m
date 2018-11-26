From: k.konieczny@partner.samsung.com (Kamil Konieczny)
Date: Mon, 26 Nov 2018 16:16:37 +0100
Subject: [PATCH 4/4] clk: samsung: exynos5433: add imem clock
In-Reply-To: <5BF5520A.5050500@samsung.com>
References: <20181121120509.18892-1-k.konieczny@partner.samsung.com>
 <CGME20181121120524eucas1p166a26857df78947c9e08f0fb8dbf75e4@eucas1p1.samsung.com>
 <20181121120509.18892-5-k.konieczny@partner.samsung.com>
 <5BF5520A.5050500@samsung.com>
Message-ID: <d4dd53a5-fb87-34db-e3b6-2d8d05feb261@partner.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> On 2018? 11? 21? 21:05, Kamil Konieczny wrote:
>> Add imem clock for exynos5433.
> 
> It is diffcult to understand the meaning of 'imem' without the description.
> Please add more detailed description as the patch2 description.
> [...]

Thank you for review, will this be enough for description:

Add imem clock for exynos5433. This will enable to use crypto Security
SubSystem (in short SSS) and SlimSSS IP blocks.

In documentation there is no description of "imem" name origin. I can guess
"mem" stand for "memory", and 'i' ? internal ?

-- 
Best regards,
Kamil Konieczny
Samsung R&D Institute Poland
