From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Mon, 22 Sep 2014 10:35:38 +0200
Subject: [PATCH] clk: samsung: exynos3250: fix width and shift of
 div_spi0_isp clock
In-Reply-To: <540EEF33.9010207@gmail.com>
References: <1410263697-768-1-git-send-email-pankaj.dubey@samsung.com>
 <540EEF33.9010207@gmail.com>
Message-ID: <541FDF5A.5060709@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09.09.2014 14:14, Krzysztof Kozlowski wrote:
> On 09.09.2014 13:54, Pankaj Dubey wrote:
>> Update shift and width field of div_spi0_isp clock as per Exynos3250
>> user manual.
>>
>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>> ---
>>   drivers/clk/samsung/clk-exynos3250.c |    2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Applied for next.

Best regards,
Tomasz
