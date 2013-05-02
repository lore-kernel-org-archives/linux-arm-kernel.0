From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Thu, 2 May 2013 13:37:26 -0600
Subject: [PATCH] irqchip: add support for Marvell Orion SoCs
In-Reply-To: <5182BFC6.3070709@gmail.com>
References: <1367519104-19677-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130502185322.GA29333@obsidianresearch.com>
 <201305022111.41043.arnd@arndb.de> <5182BFC6.3070709@gmail.com>
Message-ID: <20130502193726.GA29622@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 02, 2013 at 09:34:30PM +0200, Sebastian Hesselbarth wrote:

> >The compatible string should change if the binding changes in an
> >incomptible way, and we should try not to change it unless it's
> >fundamentally flawed.
> 
> Well, there is no _fundamental_ change in the binding syntax as it
> is only reg, interrupts, and clocks. But there is a semantic change
> in reg properties, as current orion irq controller wants the mask
> registers (0x04,0x08) only while this also needs cause register
> (0x00).

Oh, I didn't notice that, good point - the original binding was flawed
in that regard :|

Jason
