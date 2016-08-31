From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Wed, 31 Aug 2016 18:04:28 +0200
Subject: [RFC PATCH 1/2] arm64: hw_breakpoint: convert CPU hotplug
 notifier to new infrastructure
In-Reply-To: <20160826114141.GI13554@arm.com>
References: <1472207758-24394-1-git-send-email-will.deacon@arm.com>
 <20160826112806.rr3apxva73frag5x@linutronix.de>
 <20160826114141.GI13554@arm.com>
Message-ID: <20160831160427.5nilur7ky3rxn2by@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016-08-26 12:41:41 [+0100], Will Deacon wrote:
> 
> It probably should be there anyway, since the current code is explicitly
> disabling interrupts to mitigate being called with them enabled and debug
> is something we want as early as possible.

Good. This will go via the ARM64 tree then?

> Will

Sebastian
