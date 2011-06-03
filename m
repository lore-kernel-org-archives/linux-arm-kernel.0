From: Artem.Bityutskiy@nokia.com (Artem Bityutskiy)
Date: Fri, 03 Jun 2011 18:49:19 +0300
Subject: [PATCH 2/2] mtd: drop ceiva map driver
In-Reply-To: <1307015648-17505-2-git-send-email-dbaryshkov@gmail.com>
References: <1307015648-17505-1-git-send-email-dbaryshkov@gmail.com>
	<1307015648-17505-2-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1307116159.3069.22.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-06-02 at 15:54 +0400, Dmitry Eremin-Solenikov wrote:
> The same functionality is provided by physmap flash driver,
> drivers/mtd/maps/ceiva.c didn't receive any functional changes since
> the start of current git history, so drop it.
> 
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>

How about this: I take this patch to l2-mtd-2.6, but not taking the
first patch. If someone complains that he needs ceiva, we'll add you
first patch. Otherwise, you should kill all the other ceiva bits. Is
this OK?

-- 
Best Regards,
Artem Bityutskiy (????? ????????)
