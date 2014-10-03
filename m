From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 3 Oct 2014 09:50:17 -0400
Subject: [PATCH 0/2] Marvell Armada 375/38x MPIC/MSI fixes
In-Reply-To: <1411643839-64925-1-git-send-email-jaz@semihalf.com>
References: <1411643839-64925-1-git-send-email-jaz@semihalf.com>
Message-ID: <20141003135017.GH3895@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 25, 2014 at 01:17:17PM +0200, Grzegorz Jaszczyk wrote:
> This patchset contains a set of fixes for issues found while doing some test
> with different interrupts configuration on Armada 375 and Armada 38x Marvell
> SoCs. The patches were tested and apply on v3.17-rc6.
> 
> Any feedback is welcome.
> 
> Grzegorz Jaszczyk (2):
>   irqchip: armada-370-xp: fix MSI interrupt handling
>   irqchip: armada-370-xp: fix MPIC interrupt handling
> 
>  drivers/irqchip/irq-armada-370-xp.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)

Ah crap.  This slipped off my plate.  Sorry about that.  I've now
applied these to irqchip/urgent with Ezequiel's Ack.  I'll get them into
-next and hopefully do a PR toward the end of next week.

thx,

Jason.
