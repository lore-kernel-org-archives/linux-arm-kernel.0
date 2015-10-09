From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 9 Oct 2015 22:19:27 +0100
Subject: [PULL] GIC changes for Linux 4.4
In-Reply-To: <alpine.DEB.2.11.1510092251420.6097@nanos>
References: <1444404432-1992-1-git-send-email-marc.zyngier@arm.com>
 <alpine.DEB.2.11.1510092251420.6097@nanos>
Message-ID: <20151009221927.597a0f82@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 9 Oct 2015 22:52:48 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Fri, 9 Oct 2015, Marc Zyngier wrote:
> > The following changes since commit 049e6dde7e57f0054fdc49102e7ef4830c698b46:
> > 
> >   Linux 4.3-rc4 (2015-10-04 16:57:17 +0100)
> 
> That's not the best base. tip irq/core already has gic modifications
> which conflict. Can you please rebase to tip irq/core?

Damn, completely forgot about the Cavium stuff. Sorry. I'll rebase and
resend.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
