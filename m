From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 5 Mar 2014 10:24:17 +0100
Subject: [PATCH] Revert "irqchip: irq-dove: Add PMU interrupt controller."
In-Reply-To: <20140305004139.GT21483@n2100.arm.linux.org.uk>
References: <20140304030838.GA1872@titan.lakedaemon.net>
 <1393911160-7688-1-git-send-email-jason@lakedaemon.net>
 <20140305004139.GT21483@n2100.arm.linux.org.uk>
Message-ID: <20140305092417.GB26485@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >From the spec, it looks like this is probably true of DFSDone as well.

The cpufreq driver makes use of DFSDone. I've never had it loop
endlessly. There is also no action needed to clear it in the DFS
hardware.

	Andrew
