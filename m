From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 3 Jun 2014 09:50:11 +0200
Subject: [PATCH 1/5] ARM: berlin: add SMP support
In-Reply-To: <20140603141913.710a1f7e@xhacker>
References: <1401700866-24804-1-git-send-email-antoine.tenart@free-electrons.com>
 <1401700866-24804-2-git-send-email-antoine.tenart@free-electrons.com>
 <20140602094715.GG28090@lunn.ch> <20140602100048.GA12162@kwain>
 <20140602100332.GH28090@lunn.ch> <20140602102750.GB13681@kwain>
 <20140603141913.710a1f7e@xhacker>
Message-ID: <20140603075011.GA22742@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> We don't support independently power off cpu on BG2 and BG2Q in linux kernel.
> So we can assume that bootloader has powered on the CPUs

Can i assume from your answer that the hardware does actually support
independent power off/on of CPUs? It could be added sometime in the
future.

	Andrew
