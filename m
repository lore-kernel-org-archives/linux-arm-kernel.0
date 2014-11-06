From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 6 Nov 2014 12:59:25 +0100 (CET)
Subject: [Patch Part2 v4 21/31] PCI/MSI: enhance PCI MSI core to support
 hierarchy irqdomain
In-Reply-To: <545B5E5B.8090300@linux.intel.com>
References: <1415102525-9898-1-git-send-email-jiang.liu@linux.intel.com>
 <1415102525-9898-22-git-send-email-jiang.liu@linux.intel.com>
 <alpine.DEB.2.11.1411061023400.24960@nanos>
 <545B5E5B.8090300@linux.intel.com>
Message-ID: <alpine.DEB.2.11.1411061258560.24960@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 6 Nov 2014, Jiang Liu wrote:
> On 2014/11/6 18:01, Thomas Gleixner wrote:
> Hi Thomas,
> 	Actually I'm working on a patch set to improve MSI support in
> the way you described above this afternoon. And I'm also trying to
> split MSI code into PCI dependent part and PCI independent part.
> I plan to add a file kernel/irq/msi.c to host PCI independent part,

kernel/irq/msi.c is fine.

Thanks,

	tglx
