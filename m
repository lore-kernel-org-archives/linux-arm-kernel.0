From: fengguang.wu@intel.com (Fengguang Wu)
Date: Thu, 9 Jan 2014 19:46:19 +0800
Subject: [PATCH V3 Resend] cpufreq: create cpufreq_generic_get() routine
In-Reply-To: <CAKohpo=EsaBPdF3wYsa2rEdjcpPagbhPcxWw1_PA=yVLDnjRiA@mail.gmail.com>
References: <d9239e0a5df99392647ff8343673342f89d09476.1389059568.git.viresh.kumar@linaro.org>
 <CAOesGMgfFVoVJpOMXWtzVWj_F4pD-L9Osyv4u6=c8RUWOoLHFw@mail.gmail.com>
 <CAKohpo=EsaBPdF3wYsa2rEdjcpPagbhPcxWw1_PA=yVLDnjRiA@mail.gmail.com>
Message-ID: <20140109114619.GA20423@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Viresh,

> @Fengguang: Would it make sense to add build tests for all ARM
> defconfigs in your build system? I thought its already there :)
> That way I can always be sure that my stuff (would be helpful for
> others as well though) isn't breaking build (Atleast) for any platform.

Sure. I just added build test workers for all defconfigs from all
archs. Note that due to the large number of configs, they'll have
longer delays, but should still finish in one day.

Thanks,
Fengguang
