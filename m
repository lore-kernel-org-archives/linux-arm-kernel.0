From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Tue, 15 Apr 2014 17:41:58 +0900
Subject: [PATCHv2 3/8] ARM: EXYNOS: Add IO mapping for PMU of Exynos3250
In-Reply-To: <CAGm_ybhGBVmUu9PgppgWfH8b8=3JVhqK0v=ZR_yE8Cs42+VUOg@mail.gmail.com>
References: <1397527192-21988-1-git-send-email-cw00.choi@samsung.com>
 <1397527192-21988-4-git-send-email-cw00.choi@samsung.com>
 <4788081.xvaJfdGTMu@wuerfel> <534CEEA8.6020800@samsung.com>
 <CAGm_ybhGBVmUu9PgppgWfH8b8=3JVhqK0v=ZR_yE8Cs42+VUOg@mail.gmail.com>
Message-ID: <534CF0D6.5030400@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 04/15/2014 05:39 PM, Vikas Sajjan wrote:
> Hi,
> 
> On Tue, Apr 15, 2014 at 2:02 PM, Chanwoo Choi <cw00.choi@samsung.com> wrote:
>> Hi,
>>
>> On 04/15/2014 05:11 PM, Arnd Bergmann wrote:
>>> On Tuesday 15 April 2014 10:59:47 Chanwoo Choi wrote:
>>>> This patch add memory mapping for PMU (Power Management Unit) which is used
>>>> for power control of Exynos3250.
>>>>
>>>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>>>> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
>>>> ---
>>>> Arnd Bergmann suggested that need proper driver instead of static memory mapping.
>>>> As Chanho Park reply[2], Sachin Kamat already posted the DT support patch[1]
>>>> for memory mapping for SYSRAM.
>>>> [1] http://www.spinics.net/lists/linux-samsung-soc/msg27647.html
>>>> [2] https://lkml.org/lkml/2014/4/10/161
>>>>
>>>> So, I'm going to re-implement following patch related to static memory mapping
>>>> after merged Sachin Kamat patch[1].
>>>>   ARM: EXYNOS: Add IO mapping for PMU of Exynos3250
>>>
>>> I don't think we have a patch for the PMU yet, Sachin was looking at the SYSRAM
>>> only.
>>
>> You are right. Sachin's patch only included the solution of SYSRAM memory mapping.
>> I set out the plan that I would implment proper driver for PMU memory mapping
>> instead of static method after merged Sachin's patch for SYSRAM.
>>
>> But,
>> If you'd like me to implment PMU memory mapping instead of static mapping right now,
>> I'll implement it for PMU such as Sachin's patch on next posting(v3).
>>
> 
> I have already posted patch[1] for mapping PMU through DT as part of
> my PMU series for exynos5260.
> You can rebase on the same.
> 
> 
> [1] http://www.spinics.net/lists/arm-kernel/msg316013.html

OK, I'll rebase it after merged PMU mapping patch[1].

Thanks,
Chanwoo Choi
