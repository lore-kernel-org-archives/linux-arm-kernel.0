From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 5 Jul 2012 14:58:01 +0200
Subject: [PATCH v2 01/12] ARM: Orion: DT support for IRQ and GPIO
 Controllers
In-Reply-To: <20120705094824.GO17534@lunn.ch>
References: <1341325365-21393-1-git-send-email-andrew@lunn.ch>
 <1341325365-21393-2-git-send-email-andrew@lunn.ch>
 <20120705110251.596331e0@skate> <20120705094824.GO17534@lunn.ch>
Message-ID: <20120705145801.4985770d@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Le Thu, 5 Jul 2012 11:48:24 +0200,
Andrew Lunn <andrew@lunn.ch> a ?crit :

> The biggest problem i had, is the interaction between generic chip
> interrupts and irqdomain. There has been work to integrate the two,
> but its stalled. Either the work needs restarting and completing, or
> you need to throw away the use of generic interrupt so that you can
> use irqdomain linear. IMHO, throwing away generic interrupt is the
> wrong way.

Can you expand on why you think it would be wrong to throw away the
usage of irq_chip_generic, compared to implementing directly an
irq_chip?

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
