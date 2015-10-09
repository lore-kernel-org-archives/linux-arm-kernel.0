From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 9 Oct 2015 22:52:48 +0200 (CEST)
Subject: [PULL] GIC changes for Linux 4.4
In-Reply-To: <1444404432-1992-1-git-send-email-marc.zyngier@arm.com>
References: <1444404432-1992-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <alpine.DEB.2.11.1510092251420.6097@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 9 Oct 2015, Marc Zyngier wrote:
> The following changes since commit 049e6dde7e57f0054fdc49102e7ef4830c698b46:
> 
>   Linux 4.3-rc4 (2015-10-04 16:57:17 +0100)

That's not the best base. tip irq/core already has gic modifications
which conflict. Can you please rebase to tip irq/core?

Thanks,

	tglx
