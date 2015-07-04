From: tglx@linutronix.de (Thomas Gleixner)
Date: Sat, 4 Jul 2015 15:42:06 +0200 (CEST)
Subject: [PATCH v2 2/2] irqchip: dw-apb-ictl: add irq_set_affinity support
In-Reply-To: <20150704211602.2b8c3632@xhacker>
References: <1435987170-3962-1-git-send-email-jszhang@marvell.com>
 <1435987170-3962-3-git-send-email-jszhang@marvell.com>
 <20150704082623.GA7557@n2100.arm.linux.org.uk>
 <alpine.DEB.2.11.1507041151010.3916@nanos>
 <20150704100827.GC7557@n2100.arm.linux.org.uk>
 <alpine.DEB.2.11.1507041437470.3916@nanos> <20150704211602.2b8c3632@xhacker>
Message-ID: <alpine.DEB.2.11.1507041540520.3916@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 4 Jul 2015, Jisheng Zhang wrote:
> Thank you for your suggestion. Is is acceptable to make an config option
> such as DW_APB_ICTL_SET_AFFINITY, and warn enabled this would migrates every
> interrupt, and disable it by default?

No, this wants to be a runtime/boottime configuration (device tree
might be a possible solution).

Thanks,

	tglx
