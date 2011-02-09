From: dima@android.com (Dima Zavin)
Date: Wed, 9 Feb 2011 13:39:15 -0800
Subject: [PATCH] ARM: mm: enforce pageblock alignment when freeing memmap
	entries at init
In-Reply-To: <20110203133053.GG11958@csn.ul.ie>
References: <1295567231-2384-1-git-send-email-dima@android.com>
	<20110126082916.GM18984@csn.ul.ie>
	<AANLkTimrP4u5VJBVGCK0tXZo6G2S4tXJnJcqc0+oVeeF@mail.gmail.com>
	<20110203133053.GG11958@csn.ul.ie>
Message-ID: <AANLkTi=eZizF2Wu-4D8MWM-8qi00S_sm4ke5LM6jaoaA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mel,

> Sorry for the long delay. I'm in the process of changing jobs at the
> moment and my schedule is heavily disrupted. It's likely to be a mess
> for at least a month.

I totally understand. Good luck with the new job :)

> No, the description and patch comment is just misleading. Clarify that
> you are catching the situation where a node boundary is in the middle of a
> MAX_ORDER_NR_PAGES block of pages and you are preventing memmap belonging
> to another node being freed and it's fine.

Will resend with new description.

Thanks

--Dima
