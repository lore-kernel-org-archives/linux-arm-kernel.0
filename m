From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 10 Dec 2010 10:00:12 +0000
Subject: [PATCH] arm: dma-mapping: move consistent_init to early_initcall
In-Reply-To: <4D017B45.4000805@codeaurora.org>
References: <1291327879-28073-1-git-send-email-johlstei@codeaurora.org>
	<20101202221909.GK29347@n2100.arm.linux.org.uk>
	<4CF94DDD.8000409@codeaurora.org>
	<20101203203653.GB10245@n2100.arm.linux.org.uk>
	<4CFDD297.4020600@codeaurora.org>
	<15d23d63900e4545a40555961c49c421.squirrel@codeaurora.org>
	<20101209103835.GA31465@n2100.arm.linux.org.uk>
	<4D017B45.4000805@codeaurora.org>
Message-ID: <AANLkTi=PnnT8rVKMxK0tVTdKnKdcKf71fsX2o594Qx3e@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 December 2010 00:58, Saravana Kannan <skannan@codeaurora.org> wrote:
> Russell King - ARM Linux wrote:
>>
>> On Thu, Dec 09, 2010 at 01:23:24AM -0800, skannan at codeaurora.org wrote:
>>>
>>> Russell, Have you had a chance to look at this? Any comments? How do we
>>> move ahead?
>>
>> I had connected the other thread with this one - it's pretty hard not
>> to as it included this patch in that set as the first patch.
>
> Ok. So what's your take on handling the cache coherency with secure domain?
> Do we get to add cache invalidate APIs outside of DMA APIs?

Can the secure software not create NS pages and be fully coherent?

-- 
Catalin
