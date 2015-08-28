From: michael@dinsnail.net (Michael Weiser)
Date: Fri, 28 Aug 2015 21:02:25 +0200
Subject: no booting due to handle_domain_irq on orion5x/kurobox
In-Reply-To: <87vbbz75vf.fsf@free-electrons.com>
References: <20150828155826.GD2776@dinsnail.net>
 <87vbbz75vf.fsf@free-electrons.com>
Message-ID: <20150828190225.GA26848@weiser.dinsnail.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

On Fri, Aug 28, 2015 at 06:08:36PM +0200, Gregory CLEMENT wrote:
> The good new is that a fix have already been submitted, the bad news is
> that it won't be in 4.2, but it will be in 4.3-rc1 and as it was tagged
> as stable it would be part of the older stable kernel in the next weeks.
> You can cherry-pick it from linux-next:

> http://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/?id=5be9fc23cdb42e1d383ecc8eae8a8ff70a752708

Awesome, thanks!
-- 
Micha
