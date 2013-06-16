From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 17 Jun 2013 06:03:44 +0900
Subject: [PATCH v2 2/3] ARM: SAMSUNG: Consolidate uncompress subroutine
In-Reply-To: <51B960D6.7080901@linaro.org>
References: <1370319552-17694-1-git-send-email-tushar.behera@linaro.org>
 <1370319552-17694-3-git-send-email-tushar.behera@linaro.org>
 <51B960D6.7080901@linaro.org>
Message-ID: <51BE2830.2070702@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/13/13 15:04, Tushar Behera wrote:
> On 06/04/2013 09:49 AM, Tushar Behera wrote:
>> For mach-exynos, uart_base is a pointer and the value is calculated
>> in the machine folder. For other machines, uart_base is defined as
>> a macro in platform directory. For symmetry, the uart_base macro
>> definition is removed and the uart_base calculation is moved to
>> specific machine folders.
>>
>> This would help us consolidating uncompress subroutine for s5p64x0.
>>
>> Signed-off-by: Tushar Behera<tushar.behera@linaro.org>
>> ---
>> Changes for v2:
>> * Remove ifdef's while calculating uart_base value.
>>
>
> Kukjin,
>
> Would you please queue this up for 3.11?
>
Sure, applied this and 3rd for 3.11.

Thanks,
- Kukjin
