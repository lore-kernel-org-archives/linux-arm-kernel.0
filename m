From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 25 Mar 2016 10:50:30 +0100
Subject: [PATCH v3 3/8] clk: samsung: exynos3250: Add MMC2 clock
In-Reply-To: <56F47ABC.7060006@samsung.com>
References: <1458027490-13787-1-git-send-email-cw00.choi@samsung.com>
 <1458027490-13787-4-git-send-email-cw00.choi@samsung.com>
 <56F47ABC.7060006@samsung.com>
Message-ID: <56F509E6.7080807@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chanwoo,

On 03/25/2016 12:39 AM, Chanwoo Choi wrote:
> diff --git a/include/dt-bindings/clock/exynos3250.h 
> b/include/dt-bindings/clock/exynos3250.h
>> index ddb874130d86..c796ff02ceeb 100644
>> --- a/include/dt-bindings/clock/exynos3250.h
>> +++ b/include/dt-bindings/clock/exynos3250.h
...
>> -#define CLK_NR_CLKS			249
>> +#define CLK_NR_CLKS			250

What do you think about putting all the changes to include/dt-bindings/
clock/exynos3250.h into a separate patch? Now in patch 3/8 there
is being changed again what was added in patch 2/8. However, my main
point is to have a minimum required in a common topic branch for the clk
and the arm-soc trees, so there is no need for arm-soc to pull all
the drives/clk changes.
It might not be that sensible in case of just those 2 patches in your
series, nevertheless it would be good to keep that in mind for future
submissions.

--
Thanks,
Sylwester
