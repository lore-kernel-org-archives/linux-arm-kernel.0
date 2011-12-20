From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 20 Dec 2011 14:37:08 +0000
Subject: [PATCH] ARM: drop unused parameter from flush_cache_user_range
In-Reply-To: <1323985698-6371-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1323985698-6371-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <CAHkRjk5XOPjRSDaX2P0YxV7Vv_ddZSpVLnGVMOOGSJ8rzOeEAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/12/15 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> vma isn't used and flush_cache_user_range isn't a standard macro that
> is used on several archs with the same prototype. In fact only unicore32
> has a macro with the same name (with an identical implementation and no
> in-tree users).
>
> This is a part of a patch proposed by Dima Zavin (with Message-id:
> 1272439931-12795-1-git-send-email-dima at android.com) that didn't get
> accepted.
>
> Cc: Dima Zavin <dima@android.com>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

I had this change as part of Dima's other patch to solve the user
cache maintenance race (but Russell didn't like it -
http://thread.gmane.org/gmane.linux.ports.arm.kernel/139111)

-- 
Catalin
