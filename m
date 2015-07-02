From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 02 Jul 2015 09:29:49 +0900
Subject: [PATCH v5 2/3] ARM: dts: Add CPU OPP and regulator supply property
 for Exynos3250
In-Reply-To: <55947F65.8010404@samsung.com>
References: <1435756877-26736-1-git-send-email-cw00.choi@samsung.com>
 <1435756877-26736-3-git-send-email-cw00.choi@samsung.com>
 <55947F65.8010404@samsung.com>
Message-ID: <559485FD.7030805@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/02/2015 09:01 AM, Krzysztof Kozlowski wrote:
> On 01.07.2015 22:21, Chanwoo Choi wrote:
>> This patch add CPU operating points which include CPU frequency and regulator
>> voltage to use generic cpufreq drivers.
>>
>> Cc: Kukjin Kim <kgene@kernel.org>
>> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>>  arch/arm/boot/dts/exynos3250-monk.dts   |  4 ++++
>>  arch/arm/boot/dts/exynos3250-rinato.dts |  4 ++++
>>  arch/arm/boot/dts/exynos3250.dtsi       | 15 +++++++++++++++
>>  3 files changed, 23 insertions(+)
> 
> The patch looks good. Could you put the 'cpu' nodes in alphabetical
> order? The order for Rinato board is already broken but still putting it
> after 'adc' node would be better.
> 
> With the change above:
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

OK. I'll resend it.

Thanks,
Chanwoo Choi
