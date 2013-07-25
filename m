From: sylvester.nawrocki@gmail.com (Sylwester Nawrocki)
Date: Thu, 25 Jul 2013 23:13:25 +0200
Subject: [PATCH] clk: exynos4: Add CLK_GET_RATE_NOCACHE flag for the
 Exynos4x12 ISP clocks
In-Reply-To: <20130725202337.7598.20912@quantum>
References: <1372099374-21008-1-git-send-email-s.nawrocki@samsung.com>
 <51ED2230.8080100@samsung.com> <20130725202337.7598.20912@quantum>
Message-ID: <51F194F5.8040303@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/25/2013 10:23 PM, Mike Turquette wrote:
> Quoting Sylwester Nawrocki (2013-07-22 05:14:40)
>> On 06/24/2013 08:42 PM, Sylwester Nawrocki wrote:
>>> The ISP clock registers belong to the ISP power domain and may change
>>> their values if this power domain is switched off/on. Add
>>> CLK_GET_RATE_NOCACHE flags to ensure we do not rely on invalid cached
>>> data when setting or getting frequency of those clocks.
>>>
>>> Signed-off-by: Sylwester Nawrocki<s.nawrocki@samsung.com>
>>> Signed-off-by: Kyungmin Park<kyungmin.park@samsung.com>
>>
>> Mike,
>>
>> would you consider queueing that patch for current -rc cycle ?
>
> Sylwester,
>
> Can you rebase this onto -rc2? It does not apply cleanly onto my -fixes
> branch.

Sure, I've just posted an updated version.

Thanks,
Sylwester
