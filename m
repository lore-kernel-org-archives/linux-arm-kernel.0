From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 20 Jun 2011 10:23:10 +0200
Subject: [RFC PATCH 00/16] Consolidation: move SMP local timers to
	driver/clocksource
In-Reply-To: <201106171707.23989.arnd@arndb.de>
References: <1308251204-16719-1-git-send-email-marc.zyngier@arm.com>
	<201106171707.23989.arnd@arndb.de>
Message-ID: <BANLkTiknJPXdTEZjvP60gqCBCikfYNedGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 17, 2011 at 5:07 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> Very nice stuff. Should we take this all in one branch in the arm-soc tree,
> pending Acks from the subarch maintainers?

Yes please. If Marc feels the patch set is ready I suggest you
bring it into arm-soc so it gets some testing in linux-next and
any conflicts smoked out.

> We could also push it through the individual subarch branches, but my feeling
> is that would be more work.

I agree.

Thanks,
Linus Walleij
