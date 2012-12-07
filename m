From: acourbot@nvidia.com (Alex Courbot)
Date: Fri, 7 Dec 2012 11:06:34 +0900
Subject: [RFC] gpiolib: introduce descriptor-based GPIO interface
In-Reply-To: <20121206144259.136693E0950@localhost>
References: <1354779918-4028-1-git-send-email-acourbot@nvidia.com>
 <1354779918-4028-2-git-send-email-acourbot@nvidia.com>
 <20121206144259.136693E0950@localhost>
Message-ID: <1985305.LiOKDTFPq4@percival>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 06 December 2012 22:42:59 Grant Likely wrote:
> how about "gpio_chip_hwnum()" to somewhat match irqdomain convention?

Sure, matching existing interfaces is better. "git grep hwnum" does not seem 
to reveal much related to irqdomain though?

> I've only lightly scanned this patch, but I like what I see. I would
> keep going with it.

Fantastic then - I just wanted to make sure things were not completely broken 
from the beginning. Since you and Linus W. seem to approve this, I will flush 
what I have in my head and publish a proper series for review.

Thanks!
Alex.
