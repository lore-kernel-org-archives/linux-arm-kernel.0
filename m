From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Fri, 3 Dec 2010 13:59:34 +0900
Subject: [PATCH 2/4] mach-s5pv310: Add resource definitions for mipi-csis
In-Reply-To: <012401cb92a3$a46443b0$ed2ccb10$%kim@samsung.com>
References: <1291307862-8125-1-git-send-email-s.nawrocki@samsung.com>
	<1291307862-8125-3-git-send-email-s.nawrocki@samsung.com>
	<012401cb92a3$a46443b0$ed2ccb10$%kim@samsung.com>
Message-ID: <AANLkTimEEf5eD+q-qx7gw21ryFp1bbQ084Lo=eX+Bqjz@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 3, 2010 at 1:36 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Sylwester Nawrocki wrote:
>>
>> Add IRQ and register base address definitions for mipi-csis devices.
>>
>> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>> ?arch/arm/mach-s5pv310/include/mach/irqs.h | ? ?3 +++
>> ?arch/arm/mach-s5pv310/include/mach/map.h ?| ? ?5 +++++
>> ?2 files changed, 8 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-s5pv310/include/mach/irqs.h b/arch/arm/mach-
>> s5pv310/include/mach/irqs.h
>> index 99e7dad..db63773 100644
>> --- a/arch/arm/mach-s5pv310/include/mach/irqs.h
>> +++ b/arch/arm/mach-s5pv310/include/mach/irqs.h
>> @@ -83,6 +83,9 @@
>> ?#define IRQ_HSMMC2 ? ? ? ? ? COMBINER_IRQ(29, 2)
>> ?#define IRQ_HSMMC3 ? ? ? ? ? COMBINER_IRQ(29, 3)
>>
>> +#define IRQ_MIPICSI0 ? ? ? ? COMBINER_IRQ(30, 0)
>> +#define IRQ_MIPICSI1 ? ? ? ? COMBINER_IRQ(30, 1)
>> +
>> ?#define IRQ_ONENAND_AUDI ? ? COMBINER_IRQ(34, 0)
>>
>> ?#define IRQ_EINT4 ? ? ? ? ? ?COMBINER_IRQ(37, 0)
>> diff --git a/arch/arm/mach-s5pv310/include/mach/map.h b/arch/arm/mach-
>> s5pv310/include/mach/map.h
>> index 7acf4e7..9905bfe 100644
>> --- a/arch/arm/mach-s5pv310/include/mach/map.h
>> +++ b/arch/arm/mach-s5pv310/include/mach/map.h
>> @@ -56,6 +56,9 @@
>> ?#define S5PV310_PA_GPIO2 ? ? ? ? ? ? (0x11000000)
>> ?#define S5PV310_PA_GPIO3 ? ? ? ? ? ? (0x03860000)
>>
>> +#define S5PV310_PA_CSIS0 ? ? ? ? ? ? (0x11880000)
>> +#define S5PV310_PA_CSIS1 ? ? ? ? ? ? (0x11890000)

Let us please not contain constants in brackets.
