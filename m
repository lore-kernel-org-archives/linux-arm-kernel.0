From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 07 Aug 2015 13:13:57 +0900
Subject: [PATCH v4 0/6] cpufreq: use generic cpufreq drivers for Exynos4x12
 platform
In-Reply-To: <20150807035156.GG6325@linux>
References: <1438868514-8814-1-git-send-email-b.zolnierkie@samsung.com>
 <015301d0d0a3$1396c900$3ac45b00$@kernel.org> <20150807035018.GF6325@linux>
 <20150807035156.GG6325@linux>
Message-ID: <55C43085.8090506@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07.08.2015 12:51, Viresh Kumar wrote:
> Fixed Olof's email id..
> 
> On 07-08-15, 09:20, Viresh Kumar wrote:
>> Cc'ing Rafael again. Guys please don't miss him for any PM related
>> stuff or use get_maintainers ..
>>
>> Cc'ing Arnd/Olof as well to discuss the merge stuff..
>>
>> On 07-08-15, 08:53, Kukjin Kim wrote:
>>>> Depends on:
>>>> - next-20150806 branch of linux-next kernel tree
>>>> - "[PATCH V3 00/16] OPP: Add code to support operating-points-v2 bindings"
>>>>   (http://www.spinics.net/lists/arm-kernel/msg435408.html)
>>>>
>>> BTW, hmm...how can we see this series in v4.3?...to be honest, I don't think it
>>> can be done in v4.3 because of dependencies with PM / OPP series
>>
>> That is merged by Rafael Yesterday. That is manageable 

Indeed, happy to hear it! So the patchset has no external dependencies.

>>
>>> and previous
>>> exynos CPU OPP series in each cross trees...maybe that's why you created based
>>> on linux-next...any idea?
>>
>> So there is no build dependency with OPP patches I hope, as its all
>> about using the bindings defined by them. And so you don't need to
>> depend on that.
>>
>> You might have to rebase on the ARM tree to manage your conflicts. In
>> this case you can rebase directly on ARM SoC branch which has your
>> patches (rebase directly over the last patch instead of the whole
>> branch) and make sure Olof knows about this and he doesn't update
>> (i.e. rebase) his branch, which he might not anyway.
>>
>> The whole idea is to keep a single sha-id for a commit. So you can
>> rebase over the published material present in ARM-SoC ..

Still patches 1/6 and 6/6 need your acks. Is the patch 1/6 a
prerequisite for others? It does not look like a prerequisite... but it
was put at the beginning of the patchset.

Best regards,
Krzysztof
