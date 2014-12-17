From: tony@atomide.com (Tony Lindgren)
Date: Wed, 17 Dec 2014 12:44:07 -0800
Subject: OMAP 4430 SDP: rather sick with recent kernels
In-Reply-To: <20141217190904.GF23854@atomide.com>
References: <20141217095252.GH11502@n2100.arm.linux.org.uk>
 <20141217172333.GE23854@atomide.com>
 <20141217185155.GI11502@n2100.arm.linux.org.uk>
 <20141217190904.GF23854@atomide.com>
Message-ID: <20141217204407.GG23854@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [141217 11:14]:
> 
> Also, in your 3430-LDP logs, the DMA setup_irq related "In-band Error"
> is a mystery. I'm not seeing that with omap2plus_defconfig, but can
> reproduce it here with your LDP .config file. Got any ideas on that one?

Hmm it looks like that's some CONFIG_PREEMPT related regression..
Disablig CONFIG_PREEMPT makes it go away.

Regards,

Tony
