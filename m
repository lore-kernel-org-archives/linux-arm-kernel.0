From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 9 Dec 2010 10:38:35 +0000
Subject: [PATCH] arm: dma-mapping: move consistent_init to early_initcall
In-Reply-To: <15d23d63900e4545a40555961c49c421.squirrel@codeaurora.org>
References: <1291327879-28073-1-git-send-email-johlstei@codeaurora.org>
	<20101202221909.GK29347@n2100.arm.linux.org.uk>
	<4CF94DDD.8000409@codeaurora.org>
	<20101203203653.GB10245@n2100.arm.linux.org.uk>
	<4CFDD297.4020600@codeaurora.org>
	<15d23d63900e4545a40555961c49c421.squirrel@codeaurora.org>
Message-ID: <20101209103835.GA31465@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 09, 2010 at 01:23:24AM -0800, skannan at codeaurora.org wrote:
> Russell, Have you had a chance to look at this? Any comments? How do we
> move ahead?

I had connected the other thread with this one - it's pretty hard not
to as it included this patch in that set as the first patch.
