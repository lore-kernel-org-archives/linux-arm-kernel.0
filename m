From: mxs@sbrk.org (Sebastien Rannou)
Date: Wed, 25 Feb 2015 16:56:00 +0100 (CET)
Subject: [PATCH] cpuidle: mvebu: update cpuidle thresholds for Armada XP
 SOCs
In-Reply-To: <54ED9D92.90506@linaro.org>
References: <alpine.LNX.2.02.1502131534360.8729@sbrk.sbrk.org>
 <54ED9D92.90506@linaro.org>
Message-ID: <alpine.LNX.2.02.1502251624570.11958@sbrk.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

Thanks for the explanation and thanks for the link, I wish I had read
it beforehand.

On Wed, 25 Feb 2015, Daniel Lezcano wrote:
> If you have the possibility, I would suggest to apply the right methodology to
> find the right values by using the description in the wiki page [1]. If you
> can access to the energy values to enter / exit the state and the power
> consumed in each idle state, then you can mathematically compute the right
> values.

Unfortunately I don't have access to the cost of transitions between
states, nor do I have the time taken by each transition (which I could
have used to infer the cost). I only have the power consumption of the
different states.

I plan to find the adequate values by testing different combinations,
but it is going to take some efforts before having a second
patch. Since this patch already improves the situation by using the
vendor's values, I think it is a move in the right direction, even
though not being the most adequate values.
