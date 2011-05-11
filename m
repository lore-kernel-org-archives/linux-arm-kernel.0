From: cjb@laptop.org (Chris Ball)
Date: Wed, 11 May 2011 10:40:13 -0400
Subject: [PATCH v4] sdio: optimized SDIO IRQ handling for single irq
In-Reply-To: <1305100416-5395-1-git-send-email-per.forlin@linaro.org> (Per
	Forlin's message of "Wed, 11 May 2011 09:53:35 +0200")
References: <1305100416-5395-1-git-send-email-per.forlin@linaro.org>
Message-ID: <m3d3jp2tde.fsf@pullcord.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Per,

On Wed, May 11 2011, Per Forlin wrote:
> Optimize performance for single irq
>
> Changes since v2.
>  * Rebase on mmc-next, change of line numbers no code changes.
>
> Stefan Nilsson XK (1):
>   sdio: optimized SDIO IRQ handling for single irq
>
>  drivers/mmc/core/sdio_irq.c |   33 ++++++++++++++++++++++++++++++++-
>  include/linux/mmc/card.h    |    1 +
>  2 files changed, 33 insertions(+), 1 deletions(-)

Odd, still doesn't apply here:

error: patch failed: drivers/mmc/core/sdio_irq.c:42
error: drivers/mmc/core/sdio_irq.c: patch does not apply

patch -p1 says:
Hunk #2 succeeded at 53 with fuzz 1.

So this still isn't rebased onto mmc-next properly.  There haven't been
any changes to drivers/mmc/core/sdio_irq.c since 2008, though, so now
I'm wondering where you got the fuzz from..

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
