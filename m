From: olof@lixom.net (Olof Johansson)
Date: Wed, 17 Apr 2013 23:42:17 -0700
Subject: [GIT PULL] mvebu irqchip for v3.10
In-Reply-To: <20130415195245.GU28693@titan.lakedaemon.net>
References: <20130415195245.GU28693@titan.lakedaemon.net>
Message-ID: <20130418064217.GF12816@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 15, 2013 at 03:52:45PM -0400, Jason Cooper wrote:
> 
> The following changes since commit 31880c37c11e28cb81c70757e38392b42e695dc6:
> 
>   Linux 3.9-rc6 (2013-04-07 20:49:54 -0700)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/users/jcooper/linux.git tags/irqchip-3.10
> 
> for you to fetch changes up to 5ec69017cc944f3ed88362d4b60818713a45e616:
> 
>   irqchip: armada-370-xp: slightly cleanup irq controller driver (2013-04-15 19:35:17 +0000)
> 
> ----------------------------------------------------------------
> mvebu driver irqchip for v3.10
> 
>  - move the armada irqchip driver to drivers/irqchip/
> 
> Note:
>  - I asked tglx if it was ok to take this series on 10 Apr due to it's complex
>    dependencies.  5+ days have passed with no objection.
>  - I put this driver in a separate mvebu branch in case tglx or others object,
>    it can be dropped with minimal impact to other work.


Hi,

These notes are useful to include in the pull request, but not in the
git tag -- they don't really hold much permanent value.

This branch also seems to have a few internal conflicts on mbus
changes. Not a big deal, I fixed it up, but you might as well have based
this on the other branch as well.

Merged as a late/cleanup branch.


-Olof
