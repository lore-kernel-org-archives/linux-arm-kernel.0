From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Mon, 16 Sep 2013 17:25:44 +1000
Subject: [PATCH v7 3/4] drivers: of: add initialization code for dma
 reserved memory
In-Reply-To: <5236AF64.80607@samsung.com>
References: <1377527959-5080-1-git-send-email-m.szyprowski@samsung.com>
 <1377527959-5080-4-git-send-email-m.szyprowski@samsung.com>
 <20130829224637.D09183E1222@localhost> <52209278.8040106@samsung.com>
 <DAF223EB-C84C-4E82-A24A-ACD0A3A0559F@codeaurora.org>
 <20130909160154.8D7183E0F23@localhost> <5236AF64.80607@samsung.com>
Message-ID: <1379316344.3721.6.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-09-16 at 09:12 +0200, Marek Szyprowski wrote:
> 
> Fixing those issues requires further discussion. Frankly, right now I
> really have no idea which way should I go. The /reserved-ranges node seems
> to be easy to match particular reserved memory region with a given device.
> I'm also not really convinced if it makes sense to add a code for finding
> and matching a reserved memory region to every device driver, which might
> need it. I would really like to get some more feedback on the Ben's
> comment.
> 
> In any case, the code will also change significantly, so I assume that the
> best, what can be done now is to revert the current version and start from
> the scratch with a new, complete proposal.

Yes, let's do that. I will try to help. It shouldn't be that a big deal.

Worst case, how many of us will meet physically next month in Edinburgh ?

Cheers,
Ben.
