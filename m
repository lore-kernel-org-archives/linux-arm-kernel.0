From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 17 May 2012 22:49:03 +0100
Subject: [PATCH 00/18] DT enablement for Snowball
In-Reply-To: <20120517214142.GJ26337@opensource.wolfsonmicro.com>
References: <1337262323-27692-1-git-send-email-lee.jones@linaro.org>
 <201205172125.14937.arnd@arndb.de>
 <20120517214142.GJ26337@opensource.wolfsonmicro.com>
Message-ID: <4FB5724F.4060903@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/05/12 22:41, Mark Brown wrote:
> On Thu, May 17, 2012 at 09:25:14PM +0000, Arnd Bergmann wrote:
>
>> I'm quite happy with the series overall, but it's really late for v3.5 now,
>> and I can't really judge the quality of the regulator changes. If LinusW,
>> Mark, Grant and Olof are all ok with this series, I think we can add it
>> in as a late branch for the 3.5 merge window. If there are serious
>> objections I think we should do it for 3.6 instead.

I will work though your comments first thing.

> I was just going to apply the regulator changes tomorrow morning (not
> the DT updates, just the drivers/regulator bits), I'd mostly been
> holding off to give Linus a chance to ack.

Thanks Mark.

They should be orthogonal to each other, so shouldn't require the DT 
updates straight away. Hopefully Linus will be round to it tomorrow. 
He's usually fairly efficient.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
