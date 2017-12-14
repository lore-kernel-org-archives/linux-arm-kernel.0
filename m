From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 14 Dec 2017 15:06:27 +0530
Subject: [PATCH v3 3/4] cpufreq: Add DVFS support for Armada 37xx
In-Reply-To: <87fu8dps8h.fsf@free-electrons.com>
References: <20171213175119.9441-1-gregory.clement@free-electrons.com>
 <20171213175119.9441-4-gregory.clement@free-electrons.com>
 <20171214030427.GQ3322@vireshk-i7>
 <87fu8dps8h.fsf@free-electrons.com>
Message-ID: <20171214093627.GY3322@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14-12-17, 10:35, Gregory CLEMENT wrote:
> Actually from the beginning the idea was to make difference between the
> define for the offset of the register and then the define for the value
> related to this register.
> 
> Initially I used tab for this distinction, but then I though you
> suggested to only use space to have a more compact view, so I used double
> space.
> 
> I don't mind using double space or tab, but for me making distinction
> between offset of the register and content of the register helps the
> readability of the code.

Sure, this looks fine to me.

-- 
viresh
