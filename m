From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 01 Jul 2010 16:05:15 -0000
Subject: [patch 0/2] ARM: Disable outer cache before kexec call
Message-ID: <20100701160206.539545857@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following patch series addresses the problem, that the kexec code
does not disable the outer cache before disabling the inner cache and
jumping into the new kernel. This results in random crashes of the new
kernel.

Thanks,

	tglx
