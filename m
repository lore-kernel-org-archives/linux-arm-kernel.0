From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Fri, 24 Oct 2014 19:59:22 +0900
Subject: [PATCH 2/5] clk: samsung: exynos4415: Add clocks using common
 clock framework
In-Reply-To: <544A2FF2.1000105@samsung.com>
References: <1413775749-17539-1-git-send-email-cw00.choi@samsung.com>
 <1413775935-17743-2-git-send-email-cw00.choi@samsung.com>
 <544A2FF2.1000105@samsung.com>
Message-ID: <544A310A.7090803@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/24/2014 07:54 PM, Sylwester Nawrocki wrote:
> On 20/10/14 05:32, Chanwoo Choi wrote:
>> This patch adds the new clock driver of Exynos4415 SoC based on Cortex-A9
>> using common clock framework. The CMU (Clock Management Unit) of Exynos4415
>> controls PLLs(Phase Locked Loops) and generates system clocks for CPU, buses
>> and function clocks for individual IPs.
>>
>> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
>> Cc: Tomasz Figa <tomasz.figa@gmail.com>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
>> Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>
>> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> 
> The patch looks good to me, I've applied it to my tree and will
> be sending in a pull request to Mike next week, if there is no
> objections.

Thanks,

I'll send new patchset(v2) for following Exynos4412 patches right now.

  clk: samsung: exynos4415: Add clocks using common clock framework
  clk: samsung: Document binding for Exynos4415 clock controller

Best Regards,
Chanwoo Choi
