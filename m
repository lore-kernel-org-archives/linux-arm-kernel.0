From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 10 Apr 2013 15:30:25 -0300
Subject: [PATCHv1 0/5] Marvell EBU irqchip improvements
In-Reply-To: <20130410192106.73d81f2c@skate>
References: <1365542778-27959-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130410130902.GA29100@localhost> <20130410192106.73d81f2c@skate>
Message-ID: <20130410183024.GB2275@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 10, 2013 at 07:21:06PM +0200, Thomas Petazzoni wrote:
> Dear Ezequiel Garcia,
> 
> On Wed, 10 Apr 2013 10:09:03 -0300, Ezequiel Garcia wrote:
> 
> > I'm trying to test this patchset, assuming you've based it on top of
> > v3.9-rc5.
> > 
> > However, patch 4/5 doesn't apply and I'm not really sure which
> > other patches may be depending on this.
> > 
> > Any hints?
> 
> The patch set is based on 3.9-rc6, with no other dependencies. However,
> since a patch has been applied on the mvebu IRQ controller driver
> between 3.9-rc5 and 3.9-rc6, it probably explains the fact that the
> patch set doesn't apply as is on 3.9-rc5.
> 

Indeed it applies cleanly on v3.9-rc6, thank you. On my AXP and A370 boards:

Tested-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Also, FWIW, I've applied recent Greg's fix for GPIO IRQ:
"arm: mvebu: Fix the irq map function in SMP mode"

which applies cleanly on top of your patches!
(git can be really magical)
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
