From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 09 Aug 2013 10:19:11 -0600
Subject: [PATCH 35/35] cpufreq: tegra: use
 cpufreq_table_validate_and_show()
In-Reply-To: <CAKohpo=Gy7D2LYmdFU1p+eL-nMoPE18YXWvE2M8t-fb-a5HBgg@mail.gmail.com>
References: <cover.1375964117.git.viresh.kumar@linaro.org>
 <568f3dbd414b050bb2319d960fb5044a5aed8ee3.1375964117.git.viresh.kumar@linaro.org>
 <5203BCDD.40809@wwwdotorg.org>
 <CAKohpomr8kwDitAFD7FKvHo3zNWz8qT5bkd3yOVEnC_k16o=Dw@mail.gmail.com>
 <CAKohpo=Gy7D2LYmdFU1p+eL-nMoPE18YXWvE2M8t-fb-a5HBgg@mail.gmail.com>
Message-ID: <5205167F.1070906@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/08/2013 10:04 PM, Viresh Kumar wrote:
> On 8 August 2013 21:37, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> Its useless and the correct routine isn't called at all :) .. I will add that
>> additional patch and send it to you and will get this change out of this
>> commit.
> 
> The two commits look like this now attached too in case you want
> to test:

I'd be happy to test, but those changes cause build failures on top of
next-20130809. Which other patches do I need to apply first?
