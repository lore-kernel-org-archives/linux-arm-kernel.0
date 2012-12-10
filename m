From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 10 Dec 2012 22:34:25 +0000
Subject: [RFC] gpiolib: introduce descriptor-based GPIO interface
In-Reply-To: <1985305.LiOKDTFPq4@percival>
References: <1354779918-4028-1-git-send-email-acourbot@nvidia.com>
 <1354779918-4028-2-git-send-email-acourbot@nvidia.com>
 <20121206144259.136693E0950@localhost> <1985305.LiOKDTFPq4@percival>
Message-ID: <20121210223425.DC2783E0796@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 7 Dec 2012 11:06:34 +0900, Alex Courbot <acourbot@nvidia.com> wrote:
> On Thursday 06 December 2012 22:42:59 Grant Likely wrote:
> > how about "gpio_chip_hwnum()" to somewhat match irqdomain convention?
> 
> Sure, matching existing interfaces is better. "git grep hwnum" does not seem 
> to reveal much related to irqdomain though?

irqdomain actually uses "hwirq". "hwgpio" would be a closer analog than
'hwnum'.  At first I though hwgpio to be too goofy, but on further
reflection it probably has the least likelyhood of getting used
incorrectly.

g.
