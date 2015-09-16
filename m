From: kgene@kernel.org (Kukjin Kim)
Date: Thu, 17 Sep 2015 07:44:53 +0900
Subject: [PATCH v4 0/4] cpufreq-dt: add suspend frequency support
In-Reply-To: <20150908051053.GA18554@linux>
References: <1441640501-13613-1-git-send-email-b.zolnierkie@samsung.com>
 <20150908024659.GF26760@linux> <55EE5C79.2030604@samsung.com>
 <20150908042017.GJ26760@linux> <55EE6892.3010304@samsung.com>
 <20150908051053.GA18554@linux>
Message-ID: <55F9F0E5.7000805@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/08/15 14:10, Viresh Kumar wrote:
> On 08-09-15, 13:48, Krzysztof Kozlowski wrote:
>> Somehow my mind stuck on solving Exynos4x12 cpufreq issues.
>>
>> Right, it should go through Rafael's, probably except DTS patch (4/4)
>> because it depends on previous DTS changes. These changes are still in
>> arm-soc, not in Linus' tree [0].
> 
> That's bad :(
> 
> Anyway, 4/4 is kind of independent to this series, in the sense that
> it wouldn't harm even if it gets applied separately.
> 
> So, go ahead and apply 4/4 to Samsung's tree and rest of this can be
> picked by Rafael.
> 
Applied 4/4 into samsung tree, thanks.

- Kukjin
