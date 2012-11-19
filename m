From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 19 Nov 2012 17:43:39 +0100
Subject: [PATCH 1/2] clk: mvebu: armada 370/XP add clock gating control
 provider for DT
In-Reply-To: <20121119155856.GL10259@lunn.ch>
References: <1353014906-31566-6-git-send-email-andrew@lunn.ch>
 <1353088920-17458-1-git-send-email-gregory.clement@free-electrons.com>
 <1353088920-17458-2-git-send-email-gregory.clement@free-electrons.com>
 <20121117082602.GF24569@lunn.ch>
 <50A75BB4.4070003@free-electrons.com>
 <20121117135435.GA13479@lunn.ch> <20121119164611.2e754b64@skate>
 <20121119155856.GL10259@lunn.ch>
Message-ID: <20121119174339.0ea43e5e@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Lunn,

On Mon, 19 Nov 2012 16:58:56 +0100, Andrew Lunn wrote:

> I don't think we are taking about the same clock. I mean the gate
> clock:
> 
> 28   ddr     DDR Cntrl
> 
> not the core clock.

Right, after discussion with Gregory, I found out my misunderstanding.
I'm looking now as to how this clock affects the system behavior. I
indeed see this clock ->disable() hook being called, but it doesn't
seem to cause any sort of problem on the system. It still works nicely.
So not sure this clock is actually doing something, or at least maybe
not what we think it does.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
