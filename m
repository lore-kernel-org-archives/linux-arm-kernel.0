From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 10 Dec 2013 05:37:59 +0900
Subject: [PATCH v4 2/4] clk: exynos5410: register clocks using common
 clock framework
In-Reply-To: <1914850.6CAa0SzDWP@amdc1227>
References: <1385456288-20398-1-git-send-email-v.tyrtov@samsung.com>
 <1385456288-20398-3-git-send-email-v.tyrtov@samsung.com>
 <1914850.6CAa0SzDWP@amdc1227>
Message-ID: <52A62A27.7080408@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/10/13 01:34, Tomasz Figa wrote:
> Hi Vyacheslav, Tarek,
>
> On Tuesday 26 of November 2013 12:58:06 Vyacheslav Tyrtov wrote:
>> From: Tarek Dakhran<t.dakhran@samsung.com>
>>
>> The EXYNOS5410 clocks are statically listed and registered
>> using the Samsung specific common clock helper functions.
>>
>> Signed-off-by: Tarek Dakhran<t.dakhran@samsung.com>
>> Signed-off-by: Vyacheslav Tyrtov<v.tyrtov@samsung.com>
>> ---
>>   .../devicetree/bindings/clock/exynos5410-clock.txt |  54 +++++
>>   drivers/clk/samsung/Makefile                       |   1 +
>>   drivers/clk/samsung/clk-exynos5410.c               | 239 +++++++++++++++++++++
>>   include/dt-bindings/clock/exynos5410.h             |  32 +++
>>   4 files changed, 326 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/clock/exynos5410-clock.txt
>>   create mode 100644 drivers/clk/samsung/clk-exynos5410.c
>>   create mode 100644 include/dt-bindings/clock/exynos5410.h
>
> Acked-by: Tomasz Figa<t.figa@samsung.com>
>
Tomasz, thanks for your ack on clk stuff.

> This should go through Samsung tree, I guess, since it's a dependency
> of other patches in this series and doesn't depend on any things from
> clock tree. Mike, Kukjin, are you okay with this?
>
Yeah, I'm fine on this series but 4th patch for supporting dual cluster.

Let me take 1 to 3 patches firstly. Thanks.
- Kukjin
