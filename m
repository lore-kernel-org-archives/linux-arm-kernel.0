From: olof@lixom.net (Olof Johansson)
Date: Sat, 8 Mar 2014 23:33:47 -0800
Subject: [GIT PULL 4/4] omap crossbar support for v3.15
In-Reply-To: <5313bcc5.a8fc440a.467f.7ba2SMTPIN_ADDED_MISSING@mx.google.com>
References: <pull-1393802089-910509>
 <5313bcc5.a8fc440a.467f.7ba2SMTPIN_ADDED_MISSING@mx.google.com>
Message-ID: <20140309073347.GL16310@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 02, 2014 at 03:14:49PM -0800, Tony Lindgren wrote:
> The following changes since commit 38dbfb59d1175ef458d006556061adeaa8751b72:
> 
>   Linus 3.14-rc1 (2014-02-02 16:42:13 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.15/crossbar-signed
> 
> for you to fetch changes up to 9594274201ac3c67d5c569aae63792e58bcd33e6:
> 
>   Merge branch 'crossbar_3.14_rc1' of git://github.com/Sricharanti/sricharan into omap-for-v3.15/crossbar (2014-02-28 13:35:02 -0800)
> 
> ----------------------------------------------------------------
> 
> Add support for GIC crossbar that routes interrupts on newer omaps.
> 
> Looks like people wanted these merged via the omap tree as it's
> the only user for the GIC crossbar.
> 
> ----------------------------------------------------------------
> Sricharan R (4):
>       DRIVERS: IRQCHIP: IRQ-GIC: Add support for routable irqs
>       DRIVERS: IRQCHIP: CROSSBAR: Add support for Crossbar IP
>       ARM: OMAP4+: Correct Wakeup-gen code to use physical irq number
>       ARM: DRA: Enable Crossbar IP support for DRA7XX

Whoa, lots of caps on those driver subjects. I don't think we need those
in the future, lower case is just fine (and DRIVERS: usually isn't used).

Branch has been merged into next/drivers.


-Olof
