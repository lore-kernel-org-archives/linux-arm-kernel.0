From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Mon, 21 Apr 2014 16:03:43 +0900
Subject: [PATCH 1/2] cpufreq: exynos: Use dev_err/info function instead of
 pr_err/info
In-Reply-To: <CAKohpo=-Oxu6ZoB4B2H4552meq46iXrVzKbP5ZwnG==sCc2_MA@mail.gmail.com>
References: <1397787634-9334-1-git-send-email-cw00.choi@samsung.com>
 <1397787634-9334-2-git-send-email-cw00.choi@samsung.com>
 <CAKohpo=-Oxu6ZoB4B2H4552meq46iXrVzKbP5ZwnG==sCc2_MA@mail.gmail.com>
Message-ID: <5354C2CF.5020206@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/21/2014 03:05 PM, Viresh Kumar wrote:
> On 18 April 2014 07:50, Chanwoo Choi <cw00.choi@samsung.com> wrote:
>> This patch uses dev_err/info function to show accurate log message with device name
>> instead of pr_err/info function.
>>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>>  drivers/cpufreq/exynos-cpufreq.c | 21 ++++++++++++---------
>>  drivers/cpufreq/exynos-cpufreq.h |  1 +
>>  2 files changed, 13 insertions(+), 9 deletions(-)
> 
> This still looks fine even if we don't take the new driver ?
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Thanks for your review.

Best regards,
Chanwoo Choi
