From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 26 May 2014 05:09:30 +0900
Subject: [PATCH v10 3/3] ARM: dts: Add initial device tree support for
 EXYNOS5410
In-Reply-To: <537FBA7A.3000605@gmail.com>
References: <1400841343-6016-1-git-send-email-t.dakhran@samsung.com>
 <1400841343-6016-4-git-send-email-t.dakhran@samsung.com>
 <537FBA7A.3000605@gmail.com>
Message-ID: <53824DFA.3020407@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/24/14 06:15, Tomasz Figa wrote:
> Hi Tarek,
>
> On 23.05.2014 12:35, Tarek Dakhran wrote:
>> Add initial device tree nodes for EXYNOS5410 SoC and SMDK5410 board.
>>
>> Signed-off-by: Tarek Dakhran<t.dakhran@samsung.com>
>> Signed-off-by: Vyacheslav Tyrtov<v.tyrtov@samsung.com>
>> ---
>>   arch/arm/boot/dts/Makefile                |    1 +
>>   arch/arm/boot/dts/exynos5410-smdk5410.dts |   82 ++++++++++++
>>   arch/arm/boot/dts/exynos5410.dtsi         |  206 +++++++++++++++++++++++++++++
>>   3 files changed, 289 insertions(+)
>>   create mode 100644 arch/arm/boot/dts/exynos5410-smdk5410.dts
>>   create mode 100644 arch/arm/boot/dts/exynos5410.dtsi
>
> Looks good. Hopefully we can have this patch applied soon, so it won't
> get outdated again.
>
Yes.

Tarek, please respin as soon as possible.

> Reviewed-by: Tomasz Figa<t.figa@samsung.com>
>

- Kukjin
