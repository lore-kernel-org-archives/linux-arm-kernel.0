From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 27 Aug 2013 10:53:14 -0400
Subject: [PATCH v3 0/5] Armada XP clocks for timer
In-Reply-To: <1377013554-23389-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1377013554-23389-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20130827145313.GE19598@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 20, 2013 at 12:45:49PM -0300, Ezequiel Garcia wrote:
> After the recent discussion on the device tree binding for the Armada 370/XP
> clocksource driver, Stephen Warren, Tomasz Figa and others suggested
> that the reference 25 MHz fixed-clock (aka refclk) should have a proper
> device tree representation.
> 
> (Although that's still debatable, given the 25 MHz fixed-clock seems to be
> used only by the timer/watchdog IP block.)
> 
> In addition to that and to be accurate, both timer clock inputs: nbclk and
> refclk should be exposed in the DT node for the Armada XP timer.
> 
> Following an excellent suggestion from Sebastian Hesselbarth, here's a
> patchset to accurately model the clock inputs for the timer.
> 
> Considering this is very minor improvemente from my previous patchset [1],
> I dare ask about v3.12 inclusion. On the other side, maybe it's too late already
> and it's best to keep it for v3.13.
> 
> Patches 1 and 2 apply on v3.11-rc4 plus the commit:
> "ARM: mvebu: Fix the Armada 370/XP timer compatible strings"
> that's already in mvebu/dt.

Patches 1 and 2 applied to mvebu/dt with Mike's Reviewed-by and
Gregory's Ack.

thx,

Jason.
