From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Tue, 09 Dec 2014 10:14:57 +0900
Subject: [PATCH 04/19] clk: samsung: exynos5433: Add clocks for CMU_PERIS
 domain
In-Reply-To: <54858C3C.9020701@samsung.com>
References: <1417510196-6714-1-git-send-email-cw00.choi@samsung.com>
 <1417510196-6714-5-git-send-email-cw00.choi@samsung.com>
 <54858C3C.9020701@samsung.com>
Message-ID: <54864D11.7010008@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pankaj,

On 12/08/2014 08:32 PM, Pankaj Dubey wrote:
> Hi Chanwoo,
> 
> On Tuesday 02 December 2014 02:19 PM, Chanwoo Choi wrote:
>> This patch adds missing gate clocks of CMU_PERIS domain
>> which includes TMU/TZPC/SECKEY/CHIPID/TOPRTC/EFUSE IPs.
>> The special clocks of CMU_PERIS use fin_pll source clock directly.
>>
>> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
>> Cc: Tomasz Figa <tomasz.figa@gmail.com>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Acked-by: Inki Dae <inki.dae@samsung.com>
>> Acked-by: Geunsik Lim <geunsik.lim@samsung.com>
>> ---
>>   drivers/clk/samsung/clk-exynos5433.c   | 146 ++++++++++++++++++++++++++++++++-
>>   include/dt-bindings/clock/exynos5433.h |  33 +++++++-
>>   2 files changed, 176 insertions(+), 3 deletions(-)
>>
> 
> Verified all registers and clock relationship against UM I have, and changes are OK.
> 
> Reviewed-by: Pankaj Dubey <pankaj.dubey@samsung.com>

Thanks for your review.

Best Regards,
Chanwoo Choi
