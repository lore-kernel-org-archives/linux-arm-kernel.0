From: will.deacon@arm.com (Will Deacon)
Date: Wed, 31 Aug 2016 17:50:03 +0100
Subject: [RFC PATCH 1/2] arm64: hw_breakpoint: convert CPU hotplug
 notifier to new infrastructure
In-Reply-To: <20160831160427.5nilur7ky3rxn2by@linutronix.de>
References: <1472207758-24394-1-git-send-email-will.deacon@arm.com>
 <20160826112806.rr3apxva73frag5x@linutronix.de>
 <20160826114141.GI13554@arm.com>
 <20160831160427.5nilur7ky3rxn2by@linutronix.de>
Message-ID: <20160831165002.GH29505@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 31, 2016 at 06:04:28PM +0200, Sebastian Andrzej Siewior wrote:
> On 2016-08-26 12:41:41 [+0100], Will Deacon wrote:
> > 
> > It probably should be there anyway, since the current code is explicitly
> > disabling interrupts to mitigate being called with them enabled and debug
> > is something we want as early as possible.
> 
> Good. This will go via the ARM64 tree then?

Yup, I can queue these two for 4.9 if you're happy enough with them.

Will
