From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 06 May 2010 08:50:38 +0200
Subject: SAMSUNG kernel tree merge plans
In-Reply-To: <20100506054651.GL26401@trinity.fluff.org>
References: <20100506054651.GL26401@trinity.fluff.org>
Message-ID: <015f01caece8$723e1700$56ba4500$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thursday, May 06, 2010 7:47 AM Ben Dooks wrote:

> I'm busy sorting out the trees for the next mege window, and should
> have a new next-samsung out in the next two or three days.
> 
> As such, if there is anything that needs to go via Russell's tree, then
> it needs to be merged as soon as possible. I would like to send a pull
> before Wednesday.
> 
> Anything else, if it is not merged into one of my trees by the end of
> next week (May 14th) then there is no guarantees that it will be merged.
> 
> If everyone interested in this could check my trees after the weekend and
> make any reminders of other stuff to fix at that point as there is still
> items being processed.
> 
> http://git.fluff.org/gitweb?p=bjdooks/linux.git;a=summary

We would really like to merge as much as possible from our current
development tree:
http://git.infradead.org/users/kmpark/linux-2.6-samsung/shortlog/refs/heads/SPRC-2.6.34-rc5-opensource

Some of the patches that we depend on are still in the review phase (s5p timer), some should be replaced by the ones that were
posted recently. Especially most of our patches depend on S5PV210 GPIO support, so without it we cannot go further. Is there any
chance to get it merged quickly? I will rebase our tree asap the mentioned patches get merged.

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center
