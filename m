From: joshc@codeaurora.org (Josh Cartwright)
Date: Tue, 11 Feb 2014 12:44:03 -0600
Subject: [PATCH 3/8] ARM: at91: make use of of_find_matching_node_and_match
In-Reply-To: <52FA61F4.90905@atmel.com>
References: <1392135847-30791-1-git-send-email-joshc@codeaurora.org>
 <1392135847-30791-4-git-send-email-joshc@codeaurora.org>
 <52FA61F4.90905@atmel.com>
Message-ID: <20140211184403.GH841@joshc.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 11, 2014 at 06:46:28PM +0100, Nicolas Ferre wrote:
> On 11/02/2014 17:24, Josh Cartwright :
> > Instead of the of_find_matching_node()/of_match_node() pair, which requires two
> > iterations through the match table, make use of of_find_matching_node_and_match(),
> > which only iterates through the table once.
> > 
> > While we're here, mark the rtsc id table const.
> 
> Well, I might remove this one, just because other id tables are not
> marked as "const" in the same file... So it can be good to change all of
> them in a raw.

Indeed, I was only looking for a specific pattern.

[..]
> => if you want, I can take the patch with me through arm-soc with at91
> material for 3.15 and complete your "const" modification. What do you
> think about that?

Yes, this sounds good.

Thanks,
   Josh

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
