From: tony@atomide.com (Tony Lindgren)
Date: Mon, 27 Jun 2011 04:28:43 -0700
Subject: [GIT PULL] misc. OMAP PM updates for v3.1
In-Reply-To: <87vcvw5akk.fsf@ti.com>
References: <87vcvw5akk.fsf@ti.com>
Message-ID: <20110627112843.GN23145@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kevin Hilman <khilman@ti.com> [110623 17:32]:
> Tony,
> 
> Please pull the following misc. OMAP PM updates targetted for v3.1.
> 
> This branch is based on your 'fixes' branch due to some dependencies.
>       OMAP2: PM debug: move wakeup timer into clockevent code

This won't work with the devel-timer branch. I think we should just
drop it for now based on what I mentioned in the other thread.

Regards,

Tony
