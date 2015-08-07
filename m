From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 07 Aug 2015 13:52:01 +0900
Subject: [PATCH v4 0/6] cpufreq: use generic cpufreq drivers for Exynos4x12
 platform
In-Reply-To: <20150807043037.GH6325@linux>
References: <1438868514-8814-1-git-send-email-b.zolnierkie@samsung.com>
 <015301d0d0a3$1396c900$3ac45b00$@kernel.org> <20150807035018.GF6325@linux>
 <20150807035156.GG6325@linux> <55C43085.8090506@samsung.com>
 <20150807043037.GH6325@linux>
Message-ID: <55C43971.5010504@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07.08.2015 13:30, Viresh Kumar wrote:
> On 07-08-15, 13:13, Krzysztof Kozlowski wrote:
>> Still patches 1/6 and 6/6 need your acks. Is the patch 1/6 a
>> prerequisite for others? It does not look like a prerequisite... but it
>> was put at the beginning of the patchset.
> 
> Patch 1/6 is required to get boost working, that's all.. Not sure how
> important is that. Anyway, that will work without 1/6 as well, all you
> need to do is enable CONFIG_CPU_FREQ_BOOST_SW in you .config.
> 
> Anyway, it should go via pm tree and can be sent separately.

Thanks for explanation. As fair as I understand, Bartlomiej wanted to
merge this in a way which would avoid loosing the boost mode. Kukjin
prepared topic branches for previous cpu-freq/clk stuff so maybe
everything could go through PM?

Kukjin, are you fine with that?

Best regards,
Krzysztof
