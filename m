From: mingo@elte.hu (Ingo Molnar)
Date: Thu, 14 Oct 2010 18:23:12 +0200
Subject: [PATCH] arm: perf: Fix build break due to a typo
In-Reply-To: <1287066841-28569-1-git-send-email-gadiyar@ti.com>
References: <1287066841-28569-1-git-send-email-gadiyar@ti.com>
Message-ID: <20101014162312.GA24972@elte.hu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Anand Gadiyar <gadiyar@ti.com> wrote:

> armpmu is a pointer to a structure - We need to use the structure 
> pointer operator to access num_events, and not the structure member 
> operator.
> 
> This fixes the following build break when building for OMAP4.

Yeah - i already fixed it earlier today and pushed it out.

Thanks,

	Ingo
