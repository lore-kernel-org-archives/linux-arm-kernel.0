From: alim.akhtar@samsung.com (Alim Akhtar)
Date: Wed, 13 Apr 2016 10:09:34 +0530
Subject: [PATCH] arm64: dts: Add nodes for pdma0 and pdam1 for exynos7
In-Reply-To: <570D00C6.9000203@samsung.com>
References: <1460465378-23486-1-git-send-email-alim.akhtar@samsung.com>
 <570D00C6.9000203@samsung.com>
Message-ID: <570DCD86.40208@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

On 04/12/2016 07:35 PM, Krzysztof Kozlowski wrote:
> On 04/12/2016 02:49 PM, Alim Akhtar wrote:
>> This patch adds device tree nodes for pdma0 and pdma1 controllers
>> found on exynos7 SoCs.
>>
>> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
>> ---
>>   arch/arm64/boot/dts/exynos/exynos7.dtsi |   29 +++++++++++++++++++++++++++++
>>   1 file changed, 29 insertions(+)
>>
>
> I would prefer avoid adding all new stuff at the end because it is
> conflict-prone. Alphabetical order or by address... but none of these
> are used currently. How about putting it after 'gic' node?
>
hmm....ok will send v2 with suggested changes.
Looks like other platforms also put it below 'gic'.

> Anyway the code looks fine:
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>
> Best regards,
> Krzysztof
>
>
