From: sylvester.nawrocki@gmail.com (Sylwester Nawrocki)
Date: Wed, 05 Sep 2012 21:42:23 +0200
Subject: [PATCH] ARM: Samsung: Remove unused code for the clocks debug-fs
 interface
In-Reply-To: <227c01cd8aee$638ee0d0$2aaca270$%kim@samsung.com>
References: <1346603823-14422-1-git-send-email-sylvester.nawrocki@gmail.com>
 <227c01cd8aee$638ee0d0$2aaca270$%kim@samsung.com>
Message-ID: <5047AB1F.8020308@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/05/2012 12:41 AM, Kukjin Kim wrote:
> Yeah, could be. BTW, following will fix it on Samsung platforms?

Yes, that might be better. I tried something similar but thought
it might not be worth to invest in a dead horse.. Anyway, since
converting all Samsung platforms is expected to take some time
(also all this out of tree code) probably better to apply this
fix now, before we have an alternative solution.

I noticed the most of clocks hove now reported wrong "rate" value
in this debugs-fs tree, due to not calling get_rate when needed.
It's not really important though (looks like it's by design).

--

Regards,
Sylwester
