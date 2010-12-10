From: skannan@codeaurora.org (Saravana Kannan)
Date: Thu, 09 Dec 2010 16:58:45 -0800
Subject: [PATCH] arm: dma-mapping: move consistent_init to	early_initcall
In-Reply-To: <20101209103835.GA31465@n2100.arm.linux.org.uk>
References: <1291327879-28073-1-git-send-email-johlstei@codeaurora.org>
	<20101202221909.GK29347@n2100.arm.linux.org.uk>
	<4CF94DDD.8000409@codeaurora.org>
	<20101203203653.GB10245@n2100.arm.linux.org.uk>
	<4CFDD297.4020600@codeaurora.org>
	<15d23d63900e4545a40555961c49c421.squirrel@codeaurora.org>
	<20101209103835.GA31465@n2100.arm.linux.org.uk>
Message-ID: <4D017B45.4000805@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> On Thu, Dec 09, 2010 at 01:23:24AM -0800, skannan at codeaurora.org wrote:
>> Russell, Have you had a chance to look at this? Any comments? How do we
>> move ahead?
> 
> I had connected the other thread with this one - it's pretty hard not
> to as it included this patch in that set as the first patch.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Ok. So what's your take on handling the cache coherency with secure 
domain? Do we get to add cache invalidate APIs outside of DMA APIs?

-Saravana

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
