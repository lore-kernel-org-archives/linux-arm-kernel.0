From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Fri, 30 May 2014 20:55:41 +0900
Subject: [PATCH] ARM: dts: Add pmu sysreg node to Exynos3250
In-Reply-To: <538870F8.9090507@gmail.com>
References: <1401085776-14212-1-git-send-email-cw00.choi@samsung.com>
 <538870F8.9090507@gmail.com>
Message-ID: <538871BD.2030002@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/30/2014 08:52 PM, Tomasz Figa wrote:
> On 26.05.2014 08:29, Chanwoo Choi wrote:
>> This patch add pmusysreg node for Exynos3250 to access PMU (Power Management Unit)
>> register in a centralized way using syscon driver.
>>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>>  Documentation/devicetree/bindings/arm/samsung/pmu.txt | 1 +
>>  arch/arm/boot/dts/exynos3250.dtsi                     | 5 +++++
>>  2 files changed, 6 insertions(+)
> 
> Reviewed-by: Tomasz Figa <t.figa@samsung.com>
> 

Thanks for your review.

Best Regards,
Chanwoo Choi
